require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "Access to static_pages", type: :request do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  context "Access to static pages" do
    # タイトルの引用元：Rails Tutorial
    it "should get home" do
      # アクションをgetして正常に動作することを確認する
      get root_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
    end
    # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
    it "has title 'Ruby on Rails Tutorial Sample App'" do
      expect(response.body).to include full_title("")
      expect(response.body).to_not include "| Ruby on Rails Tutorial Sample App"
    end

    # タイトルの引用元：Rails Tutorial
    it "should get help" do
      # アクションをgetして正常に動作することを確認する
      get help_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include full_title("Help")
    end

    # タイトルの引用元：Rails Tutorial
    it "should get about" do
      # アクションをgetして正常に動作することを確認する
      get about_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include full_title("About")
    end

    # タイトルの引用元：Rails Tutorial
    it "should get contact" do
      # アクションをgetして正常に動作することを確認する
      get contact_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include full_title("Contact")
    end
  end
end
