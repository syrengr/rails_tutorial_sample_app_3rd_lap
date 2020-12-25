# rails_helperを読み込む
require "rails_helper"

# 編集の失敗と成功に対するテストをする
RSpec.describe "UsersEdits", type: :system do
  # userを定義する
  let(:user) { FactoryBot.create(:user) }
  # 前処理
  before do
    # 編集の失敗に対するテスト用メソッドを呼び出す
    login_as(user)
    click_on "Setting"
  end

  # 編集の失敗に対するテスト
  scenario "it fails edit with wrong information" do
    # Nameフォームへの入力
    fill_in "Name",                   with: ""
    # Emailフォームへの入力
    fill_in "Email",                  with: "testuser@example.com"
    # Passwordフォームへの入力
    fill_in "Password",               with: "foo"
    # Confirmationフォームへの入力
    fill_in "Confirmation",           with: "bar"
    # ボタンへのクリックをシュミレートする
    click_on "Save changes"
    # 正しい数のエラーメッセージが表示されていることを期待する
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
    # 正しい数のエラーが表示されているか検証する
    aggregate_failures do
      # 現在いる場所とuserがいる場所が一致することを期待する
      expect(current_path).to eq user_path(user)
      # エラーが表示されることを期待する
      expect(has_css?(".alert-success")).to be_truthy
    end
  end
end
