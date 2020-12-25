# rails_helperを読み込む
require "rails_helper"

# フォロー／フォロワーページの認可をテストする
RSpec.describe "Users", type: :request do
  # /users/:idをPATCHリクエストするテスト
  describe "PATCH /users/:id" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # 正しい情報で編集に成功した場合のテスト
    it "succeeds ediw with correct information" do
      # nameからpassword_confirmationバリューをuserキーとparamsに代入し、user_pathへpatchリクエストをする
      patch user_path(user), params: { user: {
        name: "Foo Bar",
        email: "foo@bar.com",
        password: "",
        password_confirmation: "",
      } }
      # userページへリダイレクトすることを期待する
      expect(response).to redirect_to user_path(user)
    end
  end

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
