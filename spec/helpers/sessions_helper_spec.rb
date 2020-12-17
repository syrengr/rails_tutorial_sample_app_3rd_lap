# rails_helperを読み込む
require "rails_helper"
# test_helper_spec読み込む
require "./spec/support/test_helper_spec.rb"

# 永続セッションのテスト
RSpec.describe SessionsHelper, type: :helper do
  # TestHelperを読み込む
  include TestHelper
  # userを定義する
  let!(:user) do
    # nameからpassword_confirmationのバリューをuserキーに代入する
    create(:user, name:                  "ORIGINAL",
                  email:                 "ORIGINAL@EXAMPLE.COM",
                  password:              "password",
                  password_confirmation: "password" )
  end
  # 現在のuserのテスト
  describe "current_user" do
    # 前処理
    before do
      # 渡されたuserをrememberメソッドで記憶する
      remember(user)
    end
    # sessionがnilの場合
    it "current_user returns right when session is nil" do
      # 現在のuserが渡されたuserと同じであることを期待する
      expect(current_user).to eq user
      # user登録後のloginがtruthyであることを期待する
      expect(is_logged_in?).to be_truthy
    end
    # ダイジェストの記憶が間違っている場合
    it "current_user returns nil when remember digest is wrong" do
      # userの記憶ダイジェストが記憶トークンと正しく対応していないことを検証する
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      # 現在のuserがnilになることを期待する
      expect(current_user).to eq nil
    end
  end
end
