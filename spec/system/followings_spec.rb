# rails_helperを読み込む
require "rails_helper"

# following/followerページのテスト
RSpec.describe "Followings", type: :system do
  # ファクトリ作成
  let(:user) { FactoryBot.create(:user) }
  # ファクトリ作成
  let(:other_users) { FactoryBot.create_list(:user, 20) }
  # 前処理
  before do
    # ファクトリを取り出す
    other_users[0..9].each do |other_user|
      # followed_id作成（ユーザーのフォローを解除する）
      user.active_relationships.create!(followed_id: other_user.id)
      # follower_id作成
      user.passive_relationships.create!(follower_id: other_user.id)
    end
    # login_asメソッドを呼び出す
    login_as(user)
  end

  # フォローとフォロワーの数が正しい場合のテスト
  it "The number of following and followers is correct" do
    # ボタンへのクリックをシュミレート
    click_on "following"
    # フォロー数が10件であることを期待する
    expect(user.following.count).to eq 10
    # フォロワーを取り出す
    user.following.each do |u|
      # userページ内にリンクと名前が含まれることを期待する
      expect(page).to have_link u.name, href: user_path(u)
    end

    # フォロー数が変動しないテスト
    # ボタンへのクリックをシュミレート
    click_on "followers"
    # フォロー数が10件であることを期待する
    expect(user.followers.count).to eq 10
    # フォロワーを取り出す
    user.followers.each do |u|
      # userページ内にリンクと名前が含まれることを期待する
      expect(page).to have_link u.name, href: user_path(u)
    end

    # フォロー数が1件減少するテスト
    # userページを開く
    visit user_path(other_users.first.id)
    # 下記の挙動を期待する
    expect do
      # ボタンへのクリックをシュミレートする
      click_on "Unfollow"
      # リンクを含むことを期待する
      expect(page).not_to have_link "Unfollow"
      # currentページを開く
      visit current_path
    # フォロー数が1件減少することを期待する
    end.to change(user.following, :count).by(-1)

    # フォロワー数が1件増加するテスト
    # userページを開く
    visit user_path(other_users.last.id)
    # 下記の挙動を期待する
    expect do
      # ボタンへのクリックをシュミレートする
      click_on "Follow"
      # リンクを含むことを期待する
      expect(page).not_to have_link "Follow"
      # currentページを開く
      visit current_path
    # フォロー数が1件増加することを期待する
    end.to change(user.following, :count).by(1)
  end
end
