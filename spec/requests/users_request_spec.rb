# rails_helperを読み込む
require "rails_helper"

# indexアクションのリダイレクトをテストする
RSpec.describe "Users", type: :request do
  # GETリクエストを/usersへ送る
  describe "GET /users" do
    # loginできないときリダイレクトする
    it "redirects login when not logged in" do
      # usersページへアクセスする
      get users_path
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_url
    end
  end
end
