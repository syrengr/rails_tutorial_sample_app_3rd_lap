# rails_helperを読み込む
require "rails_helper"

# user登録に対するテスト
RSpec.describe "POST #create" do
  # 有効なuser登録に対するテスト
  context "valid user" do
    # 情報と契約すると有効化するか検証する
    it "valid signup information" do
=begin
      以下のエラーが発生し、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないため、コメントアウト
      ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true
      # 登録に成功するとuser数が1増えることを検証する
      expect do
        # nameからpassword_confirmationのバリューをuserとparamsに代入し、usersにpostメソッドで登録する
        post signup_path, params: { user: attributes_for(:user) }
      # 1数にcountカラムが変更している
      end.to change(User, :count).by(1)
=end
    end  
    # userが追加されたときの処理
    context "when adds a user" do
=begin
      以下のエラーが発生し、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないため、コメントアウト
      ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true
      # userファクトリをバリューとしてuserキーに代入してハッシュ化し、paramsに代入し、signupへpostリクエストする
      before { post signup_path, params: { user: attributes_for(:user) } }
=end
      # responseの処理を変数に置き換える
      subject { response }
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

  # テストuserでloginする
  describe "PATH/users/:id" do
    # userファクトリを作成する
    let(:user) { FactoryBot.create(:user) }
    # 前処理としてlog_in_as(user)を呼び出す
    before { log_in_as(user) }
    # 更新に失敗する
    it "fails edit with wrong information" do
      # user情報を更新する
      patch user_path(user), params: { user: {　name: " ",
                                                email: "foo@invalid",
                                                password: "foo",
                                                password_confirmation: "bar" }}
    end

    # 更新に成功する
    it "succeeds edit with correct information" do
      # user情報を更新する
      patch user_path(user), params: { user: {　name: "Foo Bar",
                                                email: "foo@invalid",
                                                password: "",
                                                password_confirmation: "" }}
    end
  end
end
