# rails_helperを読み込む
require "rails_helper"

# usersのテスト
RSpec.describe "users", type: :system do
  describe "user create a new account" do
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
        # Confirmationフォームへの入力
        fill_in "Confirmation",           with: "password"
        # ボタンへのクリックをシュミレートする
        click_button "Create my account"
      end
      # フラッシュメッセージが表示される
      it "gets an flash message" do
        # 特定の文字が表示されていることを期待する
        expect(page).to have_selector(".alert-success", text: "Welcome to the Sample App!")
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
      # 処理を変数に置き換える
      subject { page }
      # エラーメッセージの検証をする
      it "gets an errors" do
        # have_selectorのtextオプションでコンテンツ内容がマッチすることを期待する
        is_expected.to have_selector("#error_explanation")
        # have_selectorのtextオプションでコンテンツ内容がマッチすることを期待する
        is_expected.to have_selector(".alert-danger", text: "The from contains 6 errors.")
        # エラー文が2回表示されることを期待する
        is_expected.to have_content("Password can't be blank", count: 2)
      end
      # 今いるページのURLの検証をする
      it "render to /signup url" do
        # 今いるページのURLがsignupであることを期待する
        is_expected.to have_current_path "/signup"
      end
    end
  end
end
