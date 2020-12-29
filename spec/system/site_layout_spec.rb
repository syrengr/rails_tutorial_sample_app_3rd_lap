# rails_helperを読み込む
require "rails_helper"

# site layoutのテストをする
RSpec.describe "site layout", type: :system do
  # rootページへのアクセスに対するテスト
  context "access to root_path" do
    # 引数に指定したURLパスを訪問できるか検証する
    before { visit root_path }
    # page変数を使い、ページ内にリンクが存在しているか検証する
    subject { page }
    # linksの表示に対するテスト
    it "layout links" do
      # Homeページへのリンクが存在しているか検証する
      is_expected.to have_link "Home", href: root_path
      # Helpページへのリンクが存在しているか検証する
      is_expected.to have_link "Help", href: help_path
      # Log inページへのリンクが存在しているか検証する
      is_expected.to have_link "Log in", href: login_path
      # Aboutページへのリンクが存在しているか検証する
      is_expected.to have_link "About", href: about_path
      # Contactページへのリンクが存在しているか検証する
      is_expected.to have_link "Contact", href: contact_path
      # Sigun upページへのリンクが存在しているか検証する
      is_expected.to have_link "Sign up now!", href: signup_path
    end
  end
end
