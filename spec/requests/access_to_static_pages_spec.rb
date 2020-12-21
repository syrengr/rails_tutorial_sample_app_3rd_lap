# rails_helperを読み込む
require "rails_helper"

# static_pagesへのアクセスに対するテストをする
RSpec.describe "access to static_pages", type: :request do
  # homeアクションのテスト
  context "GET #home" do
    # アクションをgetして正常に動作することを検証する
    before { get root_path }
    # レスポンスに成功しているか検証する
    it "should get home" do
      # 200レスポンスが返却されていることを期待する
      expect(response).to have_http_status 200
    end
    # レスポンスの内容を検証する
    it "has title 'Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドが含まれていることを期待する
      expect(response.body).to include full_title("")
      # レスポンスに文字列"| Ruby on Rails Tutorial Sample App"が含まれていないことを期待する
      expect(response.body).to_not include "| Ruby on Rails Tutorial Sample App"
    end
  end

  # helpアクションのテスト
  context "GET #help" do
    # アクションをgetして正常に動作することを検証する
    before { get help_path }
    # レスポンスに成功しているか検証する
    it "should get help" do
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
    # レスポンスの内容を検証する
    it "has title 'Home | Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドと引数が含まれていることを期待する
      expect(response.body).to include full_title("Help")
    end
  end

  # aboutアクションのテスト
  context "GET #about" do
    # アクションをgetして正常に動作することを検証する
    before { get about_path }
    # レスポンスに成功しているか検証する
    it "should get about" do
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
    # レスポンスの内容を検証する
    it "has title 'About | Ruby on Rails Tutorial Sample App'" do
      # レスポンスにApplicationHelperのfull_titileメソッドと引数が含まれていることを検証する
      expect(response.body).to include full_title("About")
    end
  end
end
