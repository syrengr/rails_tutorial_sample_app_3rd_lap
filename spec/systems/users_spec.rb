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
      # Confirmationフォームへの入力
      fill_in "Confirmation",           with: "password"
      # ボタンへのクリックをシュミレートする
      click_button "Create my account"
    end
    # フラッシュメッセージが表示されるか検証する
    it "gets an flash message" do
      # have_selectorのtextオプションでコンテンツ内容がマッチするか検証する
      expect(page).to have_selector(".alert-success", text: "Welcome to the Sapmle App!")
    end
  end

  # 無効な値が入力されたときに表示されるエラーメッセージのテスト
  context "enter an invalid values" do
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
      # have_selectorのtextオプションでコンテンツ内容がマッチするか検証する
      is_expected.to have_selector(".alert-danger", text: "The form contains 6 errors.")
      # have_contentでコンテンツ内容を確認する
      is_expected.to have_content("Password can't be blank", count: 2)
    end
    # 今いるページのURLの検証をする
    it " render to /signup url" do
      is_expected.to have_current_path "/signup"
    end
  end
end
