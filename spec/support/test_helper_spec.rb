# rails_helperを読み込む
require "rails_helper"

# moduleの引用元：RailsチュートリアルのテストをRspecで書いてみた[第9章]
module TestHelper
  # user登録後のloginのテスト用メソッド
  def is_logged_in?
    # sessionのuser_idはnilではない
    !session[:user_id].nil?
  end

  # [remember me]チェックボックスのテスト用メソッド
  def log_in_as(user, remember_me: "1")
    # emailからremember_meキーとバリューをsessionキーとparamsに代入し、loginメソッドへpostリクエストする
    post login_path, params: { session: { email:       user.email,
                                          password:    user.password,
                                          remember_me: remember_me } }
  end
end

# rails_helperを読み込む
require "rails_helper"

# 永続セッションのテスト
RSpec.describe SessionsHelper, type: :helper do
  # TestHelperを読み込む
  include TestHelper
  # userを定義する
  let!(:user) do
    # nameからpassword_confirmationのバリューをuserキーに代入する
    create(:user, name:                  "ORIGINAL",
                  email:                 "ORIGINAL@EXAMPLE.COM",
                  password:              "password",
                  password_confirmation: "password" )
  end

  # 現在のuserのテスト
  describe "current_user" do
    # 前処理
    before do
      # 渡されたuserをrememberメソッドで記憶する
      remember(user)
    end
    # sessionがnilの場合
    it "current_user returns right when session is nil" do
      # 現在のuserが渡されたuserと同じであることを期待する
      expect(current_user).to eq user
      # user登録後のloginがtruthyであることを期待する
      expect(is_logged_in?).to be_truthy
    end
    # ダイジェストの記憶が間違っている場合
    it "current_user returns nil when remember digest is wrong" do
      # userの記憶ダイジェストが記憶トークンと正しく対応していないことを検証する
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      # 現在のuserがnilになることを期待する
      expect(current_user).to eq nil
    end
  end
end

# moduleの引用元：RailsチュートリアルのテストをRspecで書いてみた[第10章]
module SystemHelper
  # 編集の失敗に対するテスト用メソッド
  def login_as(user)
    # loginページを開く
    visit login_path
    # Emailフォームへの入力をシュミレートする
    fill_in "Email",    with: user.email
    # Passwordフォームへの入力をシュミレートする
    fill_in "Password", with: user.password
    # Log inボタンへのクリックをシュミレートする
    click_button "Log in"
  end
end

# 編集の失敗に対するテスト
RSpec.describe "UsersEdits", type: :system do
  # SystemHelperを読み込む
  include SystemHelper
  # userを定義する
  let!(:user) do
    # nameからpassword_confirmationのバリューをuserキーに代入する
    create(:user, name:                  "ORIGINAL",
                  email:                 "ORIGINAL@EXAMPLE.COM",
                  password:              "password",
                  password_confirmation: "password" )
  end
  # Capybaraではitの代わりにscenarioを使う
  scenario "it fails esit with wrong information" do
    # 編集の失敗に対するテスト用メソッドを呼び出す
    login_as(user)
    # ボタンへのクリックをシュミレートする
    # click_on "Setting"
    # fill_inメソッドでフォームへの入力をシュミレートする
    # Nameフォームへの入力
    # fill_in "Name",                   with: ""
    # Emailフォームへの入力
    # fill_in "Email",                  with: "testuser@example.com"
    # Passwordフォームへの入力
    # fill_in "Password",               with: ""
    # Confirmationフォームへの入力
    # fill_in "Confirmation",           with: ""
    # ボタンへのクリックをシュミレートする
    # click_on "Save changes"
    # 正しい数のエラーメッセージが表示されているかテスト
    # is_expected.to have_selector("The form contains 4 errors.")
  end
end
