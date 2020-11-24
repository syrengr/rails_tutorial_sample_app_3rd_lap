# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（7章）をRSpecでテスト
RSpec.describe "access to users", type: :request do
  # タイトルの引用元：Rails チュートリアル（7章）をRSpecでテスト
  describe "GET #new" do
    # タイトルの引用元：Rails チュートリアル（7章）をRSpecでテスト
    # userが追加されるときの検証
    it "adds a user" do
      # 以下の挙動を期待する
      expect do
        # paramsの値をハッシュで取得し、signupアクションに登録する
        post signup_path, params: { user: attributes_for(:user) }
      # Userモデルに1user登録されていることを期待する
      end.to change(User, :count).by(1)
    # 以下からスコープ外
    end

    # user追加されたときの検証
    context "adds a user" do
      # userモデルをハッシュで取得してuserキーに探させ、paramsに代入し、signupアクションに登録する
      before { post signup_path, params: { user: attributes_for(:user) } }
      # responseの処理を変数に置き換える
      subject { response }
      # 最後のUserをリダイレクトしていることを期待する
      it { is_expected.to redirect_to user_path(User.last) }
      # 一時的なリダイレクト302 status codeを返していることを期待する
      it { is_expected.to have_http_status 302 }
    end
  end

  # 無効なリクエスト
  context "invalid request" do
    # 無効なデータを作成
    let(:user_params) do
      attributes_for(:user, name: "",
                            email: "user@invalid",
                            password: "",
                            password_confirmation: "")
  end
  
  # userが追加されないときの検証
  it "does not add a user" do
    expect do
      post signup_path, params: { user: user_params }
    end.to change(User, :count).by(0)
  end

  #     # アクションをgetして正常に動作することを検証する
  #     get signup_path
  #     # 200レスポンスが返却されていることを検証する
  #     expect(response).to have_http_status 200
  #   end
  # end
end
