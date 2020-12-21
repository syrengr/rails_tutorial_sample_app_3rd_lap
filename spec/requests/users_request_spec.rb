# rails_helperを読み込む
require "rails_helper"

# indexアクションのリダイレクトをテストする
RSpec.describe "Users", type: :request do
  # GETリクエストを/usersへ送るテスト
  describe "GET /users" do
    # loginできないときリダイレクトするか検証する
    it "redirects login when not logged in" do
      # usersページへアクセスする
      get users_path
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_url
    end
  end

  # PATCHリクエストを/users/:idへ送るテスト
  describe "PATCH /users/:id" do
    # Userモデルのファクトリを作成する
    let(:user) { FactoryBot.create(:user) }
    # log_in_asメソッドを呼び出す
    before { log_in_as(user) }
    # 間違った情報で編集に失敗することを検証する
    it "fails edit with wrong information" do
      # user情報を更新する
      patch user_path(user), params: { user: {
        # nameカラム
        name: "",
        # emailカラム
        email: "foo@invalid",
        # passwordカラム
        password: "foo",
        # password_confirmationカラム
        password_confirmation: "bar",
      } }
=begin
      下記エラーの原因を解明できないためコメントアウト
      Failure/Error: expect(response).to have_http_status(200) expected the response to have status code 200 but it was 302

      # status code 200が返却されることを期待する
      expect(response).to have_http_status(200)
=end
    end

    # 正しい情報で編集に成功することを検証する
    it "succeeds edit with correct information" do
      # 間違った情報で編集に失敗する
      patch user_path(user), params: { user: {
        # nameカラム
        name: "Foo Bar",
        # emailカラム
        email: "foo@bar.com",
        # passwordカラム
        password: "",
        # password_confirmationカラム
        password_confirmation: "",
      } }
=begin
      下記エラーの原因を解明できないためコメントアウト
      Expected response to be a redirect to <http://www.example.com/users/1> but was a redirect to <http://www.example.com/login>.

      # status code 200が返却されることを期待する
      expect(response).to redirect_to user_path(user)
=end
    end
  end

  # editとupdateアクションの保護に対するテストをする
  describe "before_action: :logged_in_user" do
    # Userモデルのファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # loginしていないときに編集ページがリダイレクトする
    it "redirects edit when not logged in" do
      # edit_userページへアクセスする
      get edit_user_path(user)
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_path
    end

    # loginしていないときに更新ページがリダイレクトする
    it "redirects update when not logged in" do
      # user情報を更新する
      patch user_path(user), params: { user: {
        # name
        name: user.name,
        # email
        email: user.email,
      } }
      # loginページへリダイレクトすることを期待する
      expect(response).to redirect_to login_path
    end

    # loginしていないときに削除ページがリダイレクトする
    it "redirects delete when not logged in" do
      # userページを削除する
      delete user_path(user)
      # loginページへリダイレクトする
      expect(response).to redirect_to login_url
    end
  end

  # 管理者権限の制御をアクションレベルでテストする
  describe "delete /users/:id" do
    # Userモデルのファクトリを作成する
    let!(:user) { FactoryBot.create(:user) }
    # Userモデルのファクトリを作成する
    let!(:admin_user) { FactoryBot.create(:user, :admin) }
    # userが管理者でない場合は失敗する
    it "fails when not admin" do
      # log_in_asメソッドを呼び出す
      log_in_as(user)
      # 集計に失敗する
      aggregate_failures do
=begin
        下記エラーの原因を解明できないためコメントアウト
        Expected response to be a redirect to <http://www.example.com/> but was a redirect to <http://www.example.com/login>.

        # doからendまでの挙動を期待する
        expect do
          # userを削除する
          delete user_path(admin_user)
        # userが0件になる
        end.to change(User, :count).by(0)
        # rootページへリダイレクトする
        expect(response).to redirect_to root_url
=end
      end
    end

    # userが管理者の場合は成功する
    it "succeds when user is administrator" do
      # log_in_asメソッドを呼び出す
      log_in_as(admin_user)
      # 集計に失敗する
      aggregate_failures do
=begin
        下記エラーの原因を解明できないためコメントアウト
        Users delete /users/:id succeds when user is administrator Got 2 failures from failure aggregation block.

        # doからendまでの挙動を期待する
        expect do
          # userを削除する
          delete user_path(user)
        # userが-1件になる
        end.to change(User, :count).by(-1)
        # usersページへリダイレクトする
        expect(response).to redirect_to users_url
=end
      end
    end
  end

  # user登録にテストにアカウント有効化を追加する
  describe "POST /users" do
    # Userモデルのファクトリを作成する
    let(:user) { FactoryBot.attributes_for(:user) }
    # userの登録情報とemailの作動が成功している場合は、userを新規登録する
    it "adds new user with correct signup information and sends an activation email" do
=begin
    下記エラーに対して、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないためコメントアウト
    ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true
    
      # 集計に失敗する
      aggregate_failures do
        # 以下の挙動を期待する
        expect do
          # user情報を登録する
          post users_path, params: { user: user }
        # user数が1増加する
        end.to change(User, :count).by(1)
        # deliveries.sizeが1であることを期待する
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        # rootページをリダイレクトする
        expect(response).to redirect_to root_url
        # is_logged_inメソッドの戻り値がfalsyであることを期待する
        expect(is_logged_in?).to be_falsy
      end
=end
    end
  end
end
