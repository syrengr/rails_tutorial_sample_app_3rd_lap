# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "access to users", type: :request do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  describe "GET #new" do
    # タイトルの引用元：Rails Tutorial
    it "should get new" do
      get signup_path
      expect(response).to have_http_status 200
    end
  end
end
