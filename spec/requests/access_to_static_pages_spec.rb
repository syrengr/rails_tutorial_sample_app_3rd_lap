# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "Access to static_pages", type: :request do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "GET #home" do
    # アクションをgetして正常に動作することを検証する
    before { get root_path }
    # タイトルの引用元：Rails Tutorial
    it "should get home" do
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
    # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
    it "has title 'Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドが含まれていることを検証する
      expect(response.body).to include full_title("")
      # レスポンスに文字列"| Ruby on Rails Tutorial Sample App"が含まれていないことを検証する
      expect(response.body).to_not include "| Ruby on Rails Tutorial Sample App"
    end
  end

  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "GET #help" do
    # アクションをgetして正常に動作することを検証する
    before { get help_path }
    # タイトルの引用元：Rails Tutorial
    it "should get help" do
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
    # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
    it "has title 'Home | Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドと引数が含まれていることを検証する
      expect(response.body).to include full_title("Help")
    end
  end

  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "GET #about" do
    # アクションをgetして正常に動作することを検証する
    before { get about_path }
    # タイトルの引用元：Rails Tutorial
    it "should get about" do
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
    # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
    it "has title 'About | Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドと引数が含まれていることを検証する
      expect(response.body).to include full_title("About")
    end
  end

  # # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  # context "GET #contact" do
  #   # アクションをgetして正常に動作することを検証する
  #   before { contact_path }
  #   # タイトルの引用元：Rails Tutorial
  #   it "should get contact" do
  #     # 200レスポンスが返却されていることを検証する
  #     expect(response).to have_http_status 200
  #   end
  #   # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  #   it "has title 'Contact | Ruby on Rails Tutorial Sample App'" do
  #     # レスポンスにApplicationHelperのfull_titileメソッドと引数が含まれていることを検証する
  #     expect(response.body).to include full_title("Contact")
  #   end
  # end
end
