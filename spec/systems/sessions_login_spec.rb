# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（8章）をRSpecでテスト
RSpec.describe "sessions", type: :system do
  # 前処理
  before do
    # loginページを開く
    visit login_path
  end

  # login成功時のレイアウトのテスト
  describe "enter an valid values" do
    # Userモデルのpasswordとemailを作成する
    let!(:user) { create(:user, email: "loginuser@example.com", password: "password") }
    # 前処理
    before do
      # Emailフォームへの入力をシュミレートする
      fill_in "Email",    with: "loginuser@example.com"
      # Passwordフォームへの入力をシュミレートする
      fill_in "Password", with: "password"
      # ボタンへのクリックをシュミレートする
      click_button "Log in"
    end
    # logoutリンクのテスト
    it "log out after log in" do
      # "Account"リンクがあることを検証する
      is_expected.to_not have_link "Account"
      # logoutパスのリンクがnilではないことを検証する
      is_expected.to_not have_link nil, href: logout_path
      # userパスのリンクがnilではないことを検証する
      is_expected.to_not have_link nil, href: user_path(user)
    end
  end

  # login失敗時のフラッシュメッセージのテスト
  describe "enter an invalid values" do
    # 前処理
    before do
      # Emailフォームへの入力をシュミレートする
      fill_in "Email",       with: ""
      # Passwordフォームへの入力をシュミレートする
      fill_in "Password",    with: ""
      # ボタンへのクリックをシュミレートする
      click_button "Log in"
    end
    # レスポンスの処理を変数に置き換える
    subject { page }
    # フォームへの入力事項が満たされていないときに、loginページにフラッシュメッセージが表示される
    it "gets an flash messages" do
      # have_selectorのtextオプションでコンテンツ内容がマッチするか検証する
      is_expected.to have_selector(".alert-danger", text: "Invalid email/password combination")
      # 現在のパスがloginであるか検証する
      is_expected.to have_current_path login_path
    end
    # loginページから別のページへ移遷したときに、別のページではフラッシュメッセージが消える
    context "access to other page" do # contextは特定の条件が何か記述する
      # 前処理としてrootページを開く
      before { visit root_path }
      # フラッシュメッセージが消える
      it "is flash disappear" do
        # have_selectorのtextオプションでコンテンツ内容がマッチしていないと検証する
        is_expected.to_not have_selector(".alert-danger", text: "Invalid email/password combination")
      end
    end
  end

  # [remember me]チェックボックスのテスト
  describe "remember me" do
    # userを定義する
    let!(:user) do
      # nameからpassword_confirmationのバリューをuserキーに代入する
      create(:user, name:                  "ORIGINAL",
                    email:                 "ORIGINAL@EXAMPLE.COM",
                    password:              "password",
                    password_confirmation: "password" )
    end
  end
end
