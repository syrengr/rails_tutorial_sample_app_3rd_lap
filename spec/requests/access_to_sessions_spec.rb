# rails_helperを読み込む
require "rails_helper"

# ログインのテスト
RSpec.describe "access to sessions", type: :request do
  # userファクトリを作成する
  let!(:user) { create(:user) }
  # createメソッドのテスト
  describe "POST #create" do
  # ログインして詳細ページにリダイレクトを行う機能の検証をする
    it "log in and redirect to detail page" do
      # emailとpasswordバリューをsessionとparamsキーに代入し、login_pathへpostリクエストをする
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      # userページへリダイレクトすることを期待する
      expect(response).to redirect_to user_path(user)
      # is_logged_in?メソッドの戻り値がtruthyであることを期待する
      expect(is_logged_in?).to be_truthy
    end
  end

  # ログアウトしたときのセッションがnilである場合のテスト
  describe "DELETE #destroy" do
    # ログアウトしてrootページにリダイレクトを行う機能の検証をする
    it "log out and redirect to root page" do
      # 削除する
      delete logout_path
      # rootページへリダイレクトすることを期待する
      expect(response).to redirect_to root_path
      # is_logged_in?メソッドの戻り値がfalsyであることを期待する
      expect(is_logged_in?).to be_falsey
    end
  end
end
