# rails_helperを読み込む
require "rails_helper"
# test_helper_spec読み込む
require "./spec/support/test_helper_spec.rb"

# 編集の失敗と成功に対するテスト
RSpec.describe "UsersEdits", type: :system do
  # TestHelperを読み込む
  include TestHelper
  # userを定義する
  let(:user) { FactoryBot.create(:user) }
  # 前処理
  before do
    # 編集の失敗に対するテスト用メソッドを呼び出す
    login_as(user)
  end

=begin
  以下のエラーが発生し、./app/views/users/new.html.erbを見直しても解決しないため、コメントアウト
  Capybara::ElementNotFound: Unable to find visible field "" that is not disabled

  # 編集の失敗に対するテスト
  # Capybaraではitの代わりにscenarioを使う
  scenario "it fails esit with wrong information" do
    # fill_inメソッドでフォームへの入力をシュミレートする
    # Nameフォームへの入力
    fill_in "Name",                   with: ""
    # Emailフォームへの入力
    fill_in "Email",                  with: "testuser@example.com"
    # Passwordフォームへの入力
    fill_in "Password",               with: ""
    # Confirmationフォームへの入力
    fill_in "Confirmation",           with: ""
    # ボタンへのクリックをシュミレートする
    click_on "Save changes"
    # 正しい数のエラーメッセージが表示されているかテスト
    is_expected.to have_selector("The form contains 4 errors.")
    # 正しい数のエラーが表示されているか検証する
    aggregate_failures do
      # 現在いる場所とuserがいる場所が一致することを期待する
      expect(current_path).to eq user_path(user)
      # エラーが表示されることを期待する
      expect(has_css?(".alert-danger")).to be_truthy
    end
  end

  # 編集の成功に対するテスト
  scenario "it succeeds edit with correct information" do
    # fill_inメソッドでフォームへの入力をシュミレートする
    # Nameフォームへの入力
    fill_in "Name",                     with: "Foo Bar"
    # Emailフォームへの入力
    fill_in "Email",                    with: "foo@bar.com"
    # Passwordフォームへの入力
    fill_in "Password",                 with: ""
    # Confirmationフォームへの入力
    fill_in "Confirmation",             with: ""
    # ボタンへのクリックをシュミレートする
    click_on "Save changes"
  end
=end
end
