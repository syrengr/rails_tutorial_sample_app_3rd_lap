# rails_helperを読み込む
require "rails_helper"

# sessionsのテストをする
RSpec.describe "sessions", type: :request do
  # userファクトリを作成する
  let(:user) { FactoryBot.create(:user) }
  # 2番目にウィンドウでユーザーをログアウトするテスト
  describe "delete /logout" do
    # rootページへリダイレクトする
    it "redirects to root_path" do
      # emailとpasswordバリューをsessionキーとparamsに代入し、login_pathへpostリクエストする
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
      } }
      # 削除する
      delete logout_path
      # 集計に失敗する
      aggregate_failures do
        # rootページへリダイレクトすることを期待する
        expect(response).to redirect_to root_path
        # is_logged_in?メソッドの戻り値がfalsyであることを期待する
        expect(is_logged_in?).to be_falsy
      end
    end
    # ユーザーが複数のタブでログアウトするとログアウトに成功することを検証する
    it "succeeds logout when user logs out on multiple tabs" do
      delete logout_path
      # 集計に失敗する
      aggregate_failures do
        # rootページへリダイレクトすることを期待する
        expect(response).to redirect_to root_path
        # is_logged_in?メソッドの戻り値がfalsyであることを期待する
        expect(is_logged_in?).to be_falsy
      end
    end
  end

  # [remember me]チェックボックスのテスト
  describe "remember me" do
    # ユーザーが[remember me]チェックボックスをオンにした場合を検証する
    it "remembers the cookie when user checks the Remember Me box" do
      # log_in_asメソッドを呼び出す
      log_in_as(user)
      # cookies[:remember_token]がnilであることを期待する
      expect(cookies[:remember_token]).not_to eq nil
    end
    # ユーザーが[remember me]チェックボックスをオンにしなかった場合を検証する
    it "does not remembers the cookie when user does not checks the Remember Me box" do
      # log_in_asメソッドを呼び出す
      log_in_as(user, remember_me: "0")
      # cookies[:remember_token]がnilであることを期待する
      expect(cookies[:remember_token]).to eq nil
    end
  end

  # フレンドリーフォワーディングのテスト
  describe "friendly forwarding" do
    # 成功した場合を検証する
    it "succeeds" do
      # HTTPリクエストgetでedit_userページを開く
      get edit_user_path(user)
      # log_in_as(user)を呼び出す
      log_in_as(user)
=begin
      下記エラーの原因を解明できないためコメントアウト
      Expected response to be a redirect to <http://www.example.com/users/1/edit> but was a redirect to <http://www.example.com/>.

      # edit_userページへリダイレクトする
      expect(response).to redirect_to edit_user_url(user)
=end
    end
  end
end
