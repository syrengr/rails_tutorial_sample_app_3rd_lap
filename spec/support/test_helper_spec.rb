# rails_helperを読み込む
require "rails_helper"

# TestHelperモジュール
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

# SystemHelperモジュール
module SystemHelper
  # 編集の失敗に対するテスト用メソッド
  def login_as(user)
    # loginページを開く
    visit login_path
    # Emailフォームへの入力をシュミレートする
    fill_in "Email",    with: "example@railstutorial.org"
    # Passwordフォームへの入力をシュミレートする
    fill_in "Password", with: "foobar"
    # Log inボタンへのクリックをシュミレートする
    click_button "Log in"
  end
end

# 設定
RSpec.configure do |config|
  # TestHelperを読み込む
  config.include TestHelper
  # SystemHelperを読み込む
  config.include SystemHelper
end
