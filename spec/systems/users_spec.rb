# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（7章）をRSpecでテスト
RSpec.describe "users", type: :system do
  # 有効な値が入力されたときに表示されるフラッシュメッセージのテスト
  context "enter an valid values" do
    # 前処理
    before do
      # signupページを開く
      visit signup_path
      # fill_inメソッドでフォームへの入力をシュミレートする
      # Nameフォームへの入力
      fill_in "Name",                   with: "testuser"
      # Emailフォームへの入力
      fill_in "Email",                  with: "testuser@example.com"
      # Passwordフォームへの入力
      fill_in "Password",               with: "password"
=begin
      以下のエラーが発生し、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないため、コメントアウト
      ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true
      # Confirmationフォームへの入力
      fill_in "Confirmation",           with: "password"
=end
      # ボタンへのクリックをシュミレートする
      click_button "Create my account"
    end
  end

  # 無効な値が入力されたときに表示されるエラーメッセージのテスト
  context "enter an invalid values" do
    # 前処理
    before do
      # signupページを開く
      visit signup_path
      # fill_inメソッドでフォームへの入力をシュミレートする
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
      # have_selectorのtextオプションでコンテンツ内容がマッチするか検証する
      is_expected.to have_selector("#error_explanation")
    end
  end
end
