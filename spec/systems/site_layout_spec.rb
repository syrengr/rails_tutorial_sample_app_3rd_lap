require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "site layout", type: :system do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "access to root_path" do
    # visitはCapybaraが提供するメソッドを使い、引数に指定したURLパスを訪問できるか確かめる
    before { visit root_path }
    # page変数を使い、ページ内にリンクが存在しているか確かめる
    subject { page }
    # タイトルの引用元：Rails Tutorial
    it "layout links" do
      # Homeページへのリンクが存在しているか確かめる
      is_expected.to have_link "Home", href: root_path
      # Helpページへのリンクが存在しているか確かめる
      is_expected.to have_link "Help", href: help_path
      # Log inページへのリンクが存在しているか確かめる
      is_expected.to have_link "Log in", href: root_path
      # Aboutページへのリンクが存在しているか確かめる
      is_expected.to have_link "About", href: about_path
      # Contactページへのリンクが存在しているか確かめる
      is_expected.to have_link "Contact", href: contact_path
    end
  end
end
