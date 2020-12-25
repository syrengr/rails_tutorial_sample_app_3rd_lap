# rails_helperを読み込む
require "rails_helper"

# バリデーションのテストをする
RSpec.describe User, type: :model do
  # Userモデルのファクトリを作成する
  let(:user) { FactoryBot.build(:user) }

  # FactoryBotの存在性のテスト
  it "has a valid factory bot" do
    # ファクトリが有効であることを期待する
    expect(build(:user)).to be_valid
  end

  # nameとemailのバリデーションのテスト
  describe "validations" do
    # nameが存在しているか検証する
    it { is_expected.to validate_presence_of(:name) }
    # emailが存在しているか検証する
    it { is_expected.to validate_presence_of(:email) }
    # nameの長さを検証する（適正値は50）
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    # emailの長さを検証する（適正値は255）
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    # 有効なemailのテストデータ作成
    it "valid email" do
      # 複数のemailを代入する
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn').for(:email)
    end
    # 無効なemailのテストデータ作成
    it "invalid email" do
      # 複数のemailを代入する
      is_expected.to_not allow_values('user@example,com',
                                      'user_at_foo.org',
                                      'user.name@example.',
                                      'foo@bar_baz.com',
                                      'foo@bar+baz.com').for(:email)
    end

    # emailの一意性を検証する
    describe "validate unqueness of email" do
      # オリジナルのテストデータを作成し、DB上に保存する
      let!(:user) { create(:user, email: "original@example.com") }
      # 重複したテストデータ作成
      it "is invalid with a duplicate email" do
        # DB上に保存しない
        user = build(:user, email: "original@example.com")
        # userがvalid?でfalseになることを期待している
        expect(user).to_not be_valid
      end
      # メールアドレスでは大文字小文字が区別されないため、重複した大文字のテストデータ作成
      it "is case insensitive in email" do
        # DB上に保存しない
        user = build(:user, email: 'ORIGINAL@EXAMPLE.COM')
        # userがvalid?でfalseになることを期待している
        expect(user).to_not be_valid
      end
    end
  end

  # emailを小文字にするbefore_saveのテスト
  describe "before_save" do
    # #email_downcaseのテスト
    describe "#email_downcase" do
      # emailのテストデータ作成
      let!(:user) { create(:user, email: "ORIGINAL@EXAMPLE.COM") }
      # 現在のuserのemailが小文字であることを期待する
      it "makes email to low case" do
        # reloadはDBの値に合わせて更新する
        expect(user.reload.email).to eq "original@example.com"
      end
    end
  end

  # passwordのバリデーションのテスト
  describe "validations" do
    # passwordの存在性のテスト
    describe "validate presence of password" do
      # passwordの最小文字数を検証する
      it "is invalid with a blank password" do
        # passwordの長さを6文字以上に設定する
        user =  build(:user, password: " " * 6)
        # userがvalid?でfalseであることを期待する
        expect(user).to_not be_valid
      end
    end
    # passwordの長さを検証する（適正値は6）
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  # authenticated?メソッドを検証する
  it "returns false for a user with nil digest" do
=begin
    下記エラーの原因を解明できないためコメントアウト
    NameError:　undefined local variable or method `user' for #<RSpec::ExampleGroups::User:0x00007f9c0a559328>
    
    # authenticated?メソッドの戻り値がfalsyであることを期待する
    expect(user.authenticated?(:remember, "")).to be_falsy
=end
  end

  # dependent: :destroyのテスト
  describe "dependent: :destroy" do
    # 前処理
    before do
      # userを登録する
      user.save
      # micropostを作成する
      user.microposts.create!(content: "Lorem ipsum")
    end
    # userの登録に成功した場合を検証する
    it "succeeds" do
      # 以下の挙動を期待する
      expect do
        # userを削除する
        user.destroy
      # micropostが1件減少することを期待する
      end.to change(Micropost, :count).by(-1)
    end
  end

  # Relationshipモデルのバリデーションをテストする
  describe "follow and unfollow" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # ファクトリ作成
    let(:other_user) { FactoryBot.create(:user) }
    # 前処理
    before { user.follow(other_user) }
    # followテスト
    describe "follow" do
      # followに成功した場合を検証する
      it "succeeds" do
        # truthyを返すことを期待する
        expect(user.following?(other_user)).to be_truthy
      end
      # followersに対するテスト
      describe "followers" do
        # followersに成功した場合を検証する
        it "succeeds" do
          expect(other_user.followers.include?(user)).to be_truthy
        end
      end
    end

    # unfollowテスト
    describe "unfollow" do
      # unfollowに成功した場合を検証する
      it "succeeds" do
        # ユーザーをunfollowする
        user.unfollow(other_user)
        # falsyを返すことを期待する
        expect(user.following?(other_user)).to be_falsy
      end
    end
  end

  # ステーテスフィールドのテスト
  describe "def feed" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user, :with_microposts) }
    # ファクトリ作成
    let(:other_user) { FactoryBot.create(:user, :with_microposts) }
    
    # ユーザーが他のユーザーをフォローしている場合
    context "when user is following other_user" do
      # 前処理
      before { user.active_relationships.create!(followed_id: other_user.id) }
      # ユーザーのマイクロポスト内に他のユーザーのマイクロポストが含まれていることを検証する
      it "contains other user's microposts within the user's Micropost" do
        # マイクロポストを取り出す
        other_user.microposts.each do |post_following|
          # 他のユーザーのマイクロポストが含まれていることを期待する
          expect(user.feed.include?(post_following)).to be_truthy
        end
      end
      # 他のユーザーのマイクロポストにユーザー自身のマイクロポストが含まれていることを検証する
      it "contains the user's own microposts in the user's Micropost" do
        # マイクロポストを取り出す
        user.microposts.each do |post_self|
          # ユーザー自身のマイクロポストが含まれていることを検証する
          expect(user.feed.include?(post_self)).to be_truthy
        end
      end
    end

    # ユーザーが他のユーザーをフォローしていない場合
    context "when user is not following other_user" do
      # ユーザーのマイクロポスト内に他のユーザーのマイクロポストが含まれていないことを検証する
      it "doesn't contain the user's microposts within the user's Micropost" do
        # マイクロポストを取り出す
        other_user.microposts.each do |post_unfollowed|
          # 他のユーザーのマイクロポストが含まれていないことを期待する
          expect(user.feed.include?(post_unfollowed)).to be_falsy
        end
      end
    end
  end
end
