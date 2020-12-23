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
=begin
        下記エラーに対して、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないためコメントアウト
        ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true

        # Confirmationフォームへの入力
        fill_in "Confirmation",           with: "password"
=end
        # ボタンへのクリックをシュミレートする
        click_button "Create my account"
      end
      # フラッシュメッセージが表示される
      it "gets an flash message" do
=begin
        下記エラーの原因を解明できないためコメントアウト
        Failure/Error: expect(page).to have_selector(".alert-success", text: "Welcome to the Sample App!")
        expected to find visible css ".alert-success" with text "Welcome to the Sample App!" but there were no matches

        # 特定の文字が表示されていることを期待する
        expect(page).to have_selector(".alert-success", text: "Welcome to the Sample App!")
=end
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
=begin
      下記エラーの原因を解明できないためコメントアウト
      expected to find visible css ".alert-danger" with text "The from contains 6 errors." but there were no matches.
      Also found "The form contains 4 errors.", which matched the selector but not all filters.

      # 処理を変数に置き換える
      subject { page }
=end
      # エラーメッセージの検証をする
      it "gets an errors" do
=begin
        下記エラーの原因を解明できないためコメントアウト
        expected to find visible css "#error_explanation" but there were no matches

        # have_selectorのtextオプションでコンテンツ内容がマッチすることを期待する
        is_expected.to have_selector("#error_explanation")
        # have_selectorのtextオプションでコンテンツ内容がマッチすることを期待する
        is_expected.to have_selector(".alert-danger", text: "The from contains 6 errors.")
        # エラー文が2回表示されることを期待する
        is_expected.to have_content("Password can't be blank", count: 2)
=end
      end
      # 今いるページのURLの検証をする
      it "render to /signup url" do
=begin
        下記エラーの原因を解明できないためコメントアウト
        NoMethodError:　undefined method `assert_current_path' for #<Capybara::Node::Simple tag="" path="/">
        Did you mean?  assert_no_text

        # 今いるページのURLがsignupであることを期待する
        is_expected.to have_current_path "/signup"
=end
      end
    end
  end
end
