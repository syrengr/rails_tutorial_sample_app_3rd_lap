require "rails_helper"

RSpec.describe "Access to static_pages", type: :request do
  context "Access to static pages" do
    it "should get home" do
      # アクションをgetして正常に動作することを確認する
      get static_pages_home_url
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "Home | Ruby on Rails Tutorial Sample App"
    end

    it "should get help" do
      # アクションをgetして正常に動作することを確認する
      get static_pages_help_url
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "Help | Ruby on Rails Tutorial Sample App"
    end

    it "should get about" do
      # アクションをgetして正常に動作することを確認する
      get static_pages_about_url
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "About | Ruby on Rails Tutorial Sample App"
    end
  end
end