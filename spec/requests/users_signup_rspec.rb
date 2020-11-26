require "POST #create"

class UsersSignupTest < ActionDispatch::IntegrationTest
  context "" do
    # 無効なuserに対するテスト
    it "invalid signup information" do
      # signupにgetメソッドでリクエストする
      get signup_path
      # 以下の挙動を期待する
      expect do
        # nameからpassword_confirmationのバリューをuserキーとparamsに代入し、usersにpostメソッドで登録する
        post users_path, params: { user: { name:                  "",
                                           email:                 "user@invalid",
                                           password:              "foo",
                                           password_confirmation: "bar" } }
        end
        # レスポンスに"users/new"が含まれていることを検証する
        expect(response).to "users/new"
        # エラーメッセージをテストする
        expect(response.body).to_not include "div#<CSS id for error explanation>"
        # エラーメッセージをテストする
        expect(response.body).to_not include "div.<CSS class for field with error>"
      end
    end
  end
end
