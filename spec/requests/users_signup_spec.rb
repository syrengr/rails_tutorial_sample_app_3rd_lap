# rails_helperを読み込む
require "rails_helper"

# user登録に対するテスト
RSpec.describe "POST #create" do
  # 有効なuser登録に対するテスト
  context "valid user" do
    # 情報と契約すると有効化するか検証する
    it "valid signup information" do
      # 登録に成功するとuser数が1増えることを検証する
      expect do
        # nameからpassword_confirmationのバリューをuserとparamsに代入し、usersにpostメソッドで登録する
        post signup_path, params: { user: attributes_for(:user) }
      # 1数にcountカラムが変更している
      end.to change(User, :count).by(1)
    end  
    # userが追加されたときの処理
    context "when adds a user" do
      # userファクトリをバリューとしてuserキーに代入してハッシュ化し、paramsに代入し、signupへpostリクエストする
      before { post signup_path, params: { user: attributes_for(:user) } }
      # responseの処理を変数に置き換える
      subject { response }
      # Userモデルの最後の列にリダイレクトすることを期待する
      it { is_expected.to redirect_to user_path(User.last) }
      # 302 status codeを返されてリダイレクトに成功することを期待する
      it { is_expected.to have_http_status 302 }
    end
  end

  # 無効なuser登録に対するテスト
  context "invalid user" do
    # user_paramsを定義する
    let(:user_params) do
      # nameからpassword_confirmationのバリューをuserキーとparamsに代入する
      attributes_for(:user, name:                  "",
                            email:                 "user@invalid",
                            password:              "foo",
                            password_confirmation: "bar")
    end
    # 情報と契約すると無効化するか検証する
    it "invalid signup information" do
      # 登録に失敗するとuser数が1増えないことを検証する
      expect do
        # user_paramsバリューをuserキーとparamsに代入し、signupへpostリクエストする
        post signup_path, params: { user: user_params }
      # 0数にcountカラムが変更している
      end.to change(User, :count).by(0)
    end
  end
end
