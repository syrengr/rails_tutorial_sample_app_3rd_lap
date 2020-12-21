# rails_helperを読み込む
require "rails_helper"

# フォロー／フォロワーページの認可をテストする
RSpec.describe "Users", type: :request do
  # userのloginを確認する
  describe "before_action: :logged_in_user" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # ログインしていないときにフォローをリダイレクトすることを検証する
    it "redirects following when not logged in" do
      # following_userページへアクセスする
      get following_user_path(user)
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_url
    end

    # ログインしていないときにフォロワーをリダイレクトすることを検証する
    it "redirects followers when not logged in" do
      # followers_userページへアクセスする
      get followers_user_path(user)
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_url
    end
  end
end
