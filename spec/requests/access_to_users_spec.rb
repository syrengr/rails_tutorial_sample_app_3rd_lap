# rails_helperを読み込む
require "rails_helper"

# usersコントローラーのテスト
RSpec.describe "access to users", type: :request do
  # createメソッドのテスト
  describe "POST #create" do

=begin
メール送信の実装を省いたためコメントアウト

    # 有効なリクエストのテスト
    context "valid request" do
      # ユーザーを追加することを検証する
      it "adds a user" do
        # 以下の挙動を期待する
        expect do
          # attributes_for(:user)バリューとuserキーをparamsに代入し、signupへpostリクエストする
          post signup_path, params: { user: attributes_for(:user) }
        # Userモデルのレコードが1件増加している
        end.to change(User, :count).by(1)
      end

      # ユーザーを追加することを検証する
      context "adds a user" do
        # 前処理
        before { post signup_path, params: { user: attributes_for(:user) } }
        # 処理を変数に置き換える
        subject { response }
        # userページへリダイレクトすることを期待する
        it { is_expected.to redirect_to user_path(User.last) }
        # status code 302が返却されることを期待する
        it { is_expected.to have_http_status 302 }
      end
    end

=end

    # 無効なリクエストのテスト
    context "invalid request" do
      # 遅延処理
      let(:user_params) do
        # テスト用の属性値をハッシュとして作成する
        attributes_for(:user, name: "",
                              email: "user@invalid",
                              password: "",
                              password_confirmation: "")
      end
      # ユーザーを追加しないことを検証する
      it "does not add a user" do
        # 下記の挙動を期待する
        expect do
          # user_paramsをuserキーとparamsに代入し、signupへpostリクエストする
          post signup_path, params: { user: user_params }
        # Userモデルのレコードが0件増加している
        end.to change(User, :count).by(0)
      end
    end
  end
  
  # newメソッドのテスト
  describe "GET #new" do
    # レスポンスに成功した場合
    it "responds successfully" do
      # signupページへアクセスする
      get signup_path
      # status code 200が返却されることを期待する
      expect(response).to have_http_status 200
    end
  end
end
