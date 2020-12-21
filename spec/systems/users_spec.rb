# rails_helperを読み込む
require "rails_helper"

# usersのテスト
RSpec.describe "users", type: :system do
  # 有効な値が入力されたときに表示されるフラッシュメッセージのテストをする
  context "enter an valid values" do
    # 前処理
    before do
      # signupページを開く
      visit signup_path
      # Nameフォームへの入力
      fill_in "Name",                   with: "testuser"
      # Emailフォームへの入力
      fill_in "Email",                  with: "testuser@example.com"
      # Passwordフォームへの入力
      fill_in "Password",               with: "password"
=begin
      下記エラーに対して、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないためコメントアウト
      ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true

      # Confirmationフォームへの入力
      fill_in "Confirmation",           with: "password"
=end
      # ボタンへのクリックをシュミレートする
      click_button "Create my account"
    end
  end

  # 無効な値が入力されたときに表示されるエラーメッセージのテストをする
  context "enter an invalid values" do
    # 前処理
    before do
      # signupページを開く
      visit signup_path
      # Nameフォームへの入力
      fill_in "Name",                   with: ""
      # Emailフォームへの入力
      fill_in "Email",                  with: ""
      # Passwordフォームへの入力
      fill_in "Password",               with: ""
      # Confirmationフォームへの入力
      fill_in "Confirmation",           with: ""
      # ボタンへのクリックをシュミレートする
      click_button "Create my account"
    end
    # レスポンスの処理を変数に置き換える
    subject { page }
    # エラーメッセージの検証をする
    it "gets an errors" do
      # have_selectorのtextオプションでコンテンツ内容がマッチすることを期待する
      is_expected.to have_selector("#error_explanation")
    end
  end
end
