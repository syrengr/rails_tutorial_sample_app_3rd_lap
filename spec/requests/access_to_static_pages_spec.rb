require "rails_helper"

RSpec.describe "Access to static_pages", type: :request do
  context "Access to static pages" do
    it "should get root" do
      # アクションをgetして正常に動作することを確認する
      get root_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
    end

    it "should get help" do
      # アクションをgetして正常に動作することを確認する
      get help_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "title", "Ruby on Rails Tutorial Sample App"
    end

    it "should get about" do
      # アクションをgetして正常に動作することを確認する
      get about_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "title", "Ruby on Rails Tutorial Sample App"
    end

    it "should get contact" do
      # アクションをgetして正常に動作することを確認する
      get contact_path
      # 200レスポンスが返却されていることを確認する
      expect(response).to have_http_status 200
      # 文字列を含むレスポンスを返していることを確認する
      expect(response.body).to include "title", "Ruby on Rails Tutorial Sample App"
    end
  end
end
