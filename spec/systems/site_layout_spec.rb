require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "site layout", type: :system do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "access to root_path" do
    # visitはCapybaraが提供するメソッドを使い、引数に指定したURLパスを訪問できるか確かめている
    before { visit root_path }
    # page変数を使い、ページ内にリンクが存在しているか確かめている
    subject { page }
    # タイトルの引用元：Rails Tutorial
    it "layout links" do
    # Homeページへのリンクが存在し、リンクが2個あるか確かめている
      is_expected.to have_link "root", href: root_path, count: 2
    # Helpページへのリンクが存在しているか確かめている
      is_expected.to have_link "Help", href: help_path
    # Aboutページへのリンクが存在しているか確かめている
      is_expected.to have_link "About", href: about_path
    end
  end
end
