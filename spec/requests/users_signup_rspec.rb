require "POST #create"

class UsersSignupTest < ActionDispatch::IntegrationTest

  # 無効なuser登録に対するテスト
  context "valid user" do
    # 情報と契約すると無効化するか検証する
    it "invalid signup information" do
      # signupにgetメソッドでリクエストする
      get signup_path
      # 登録に失敗するとuser数が1増えないことを検証する
      expect do
        # nameからpassword_confirmationのバリューをuserキーとparamsに代入し、usersにpostメソッドで登録する
        post signup_path, params: { user: { name:                  "",
                                            email:                 "user@invalid",
                                            password:              "foo",
                                            password_confirmation: "bar" } }
        # 0数にcountカラムが変更している
        end.to change(User, :count).by(0)
        # 無効なuserを登録したときに、URLが/signupになることを検証する
        expect(response).to "users/new"
        # エラーメッセージ（1）をテストする
        expect(response.body).to_not include "div#<CSS id for error explanation>"
        # エラーメッセージ（2）をテストする
        expect(response.body).to_not include "div.<CSS class for field with error>"
        # postが送信されているURLが正しいか検証する
        expect(response.body).to include 'form[action="/signup"]'
      end
    end
  end
  
  # 有効なuser登録に対するテスト
  context "invalid user" do
    # 情報と契約すると有効化するか検証する
    it "valid signup information" do
      # signupにgetメソッドでリクエストする
      get signup_path
      # 登録に成功するとuser数が1増えることを検証する
      expect do
        # nameからpassword_confirmationのバリューをuserとparamsに代入し、usersにpostメソッドで登録する
        post users_path, params: { user: { name:                  "Example User",
                                           email:                 "user@example.com",
                                           password:              "password"
                                           password_confirmation: "password" } }
      # 1数にcountカラムが変更している
      end.to change(User, :count).by(1)
      # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド（リダイレクトを追うコード）
      follow_redirect!
      # 有効なuserを登録したときに、URLが/signupになることを検証する
      expect(response).to "users/show"
      # flashメッセージが空ではないか検証する
      expect(response.body).to_not flash.empty?
    end
  end
end
