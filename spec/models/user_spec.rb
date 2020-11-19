require 'rails_helper'

# Rails Tutorial以外のタイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe User, type: :model do
  # FactoryBotが存在するか検証する
  it "has a valid factory bot" do
    # テストデータが作成されたことを期待する
    expect(build(:user)).to be_valid
  end
  
  # バリデーションを検証する（1）
  describe "validations" do
    # validate_presence_of :フィールド名で、対象のモデルの中に指定したフィールド名が存在しているか検証する
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
      is_expected.to allow_values('first.last@foo.jp',
                                  'user@example.com',
                                  'USER@foo.COM',
                                  'A_US-ER@foo.bar.org',
                                  'alice+bob@baz.cn').for(:email)
    end
    # 無効なemailのテストデータ作成
    it "invalid email" do
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

  # emailを小文字にするbefore_saveを検証する
  describe "before_save" do
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

  # バリデーションを検証する（2）
  describe "validations" do
    # passwordのバリデーションを検証する
    describe "validate presence of password" do
      # passwordの最小文字数を検証する
      it "is invalid with a blank password" do
        # passwordの長さが6文字以上であることを検証する
        user =  build(:user, password: " " * 6)
        # userがvalid?でfalseであることを期待する
        expect(user).to_not be_valid
      end
    end
    # passwordの長さを検証する（適正値は6）
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  # 以下、テストデータの作成をDB上で行ったRSpecのテスト（バリデーションのテストから、無効なemailのテストデータ作成まで）

  # # タイトルの引用元：Rails Tutorial
  # before "setup" do
  #   # テストデータ作成
  #   @user = User.new(name: "Example User", email: "user@example.com")
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "should be valid" do
  #   # @user.valid？がtrueであることを期待する
  #   expect(@user).to be_valid
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "name should be present" do
  #   # nameが空文字のテストデータ作成
  #   @user.name = ""
  #   # @user.valid?がfalseであることを期待する
  #   expect(@user).to_not be_valid
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "name should not be too long" do
  #   # nameが長すぎるテストデータ作成
  #   @user.name = "a" * 51
  #   # @user.valid?がfalseであることを期待する
  #   expect(@user).to_not be_valid
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "email should be present" do
  #   # emailが空文字のテストデータ作成
  #   @user.email = "     "
  #   # @user.valid?がfalseであることを期待する
  #   expect(@user).to_not be_valid
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "email should not be too long" do
  #   # emailが長すぎるテストデータ作成
  #   @user.email = "a" * 244 + "@example.com"
  #   # @user.valid?がfalseであることを期待する
  #   expect(@user).to_not be_valid
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "email validation should accept" do
  #   # 有効なemailのテストデータ作成
  #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  #   # テストデータを1つずつ取り出す
  #   valid_addresses.each do |valid_address|
  #     # 取り出したテストデータを代入する
  #     @user.email = valid_address
  #     # どのメールアドレスでテストを失敗したのか特定する（inspectは、オブジェクトを人間が読める形式に変換した文字列を返す）
  #     expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
  #   end
  # end

  # # タイトルの引用元：Rails Tutorial
  # it "email validation should reject invalid addresses" do
  #   # 無効なemailのテストデータ作成
  #   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.　foo@bar_baz.com foo@bar+baz.com foo@bar..com]
  #   # テストデータを1つずつ取り出す
  #   invalid_addresses.each do |invalid_address|
  #     # 取り出したテストデータを代入する
  #     @user.email = invalid_address
  #     # どのメールアドレスでテストを失敗したのか特定する（inspectは、オブジェクトを人間が読める形式に変換した文字列を返す）
  #     expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
  #   end
  # end
end
