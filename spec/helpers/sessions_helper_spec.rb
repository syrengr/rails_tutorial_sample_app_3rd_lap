# rails_helperを読み込む
require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  # userを定義する
  let!(:user) do
    # nameからpassword_confirmationのバリューをuserキーに代入する
    create(:user, name:                  "ORIGINAL",
                  email:                 "ORIGINAL@EXAMPLE.COM",
                  password:              "password",
                  password_confirmation: "password" )
  end

  describe "current_user" do
    before do
      remember(user)
    end
    it "current_user returns right when session is nil" do
      expect(current_user).to eq user
      # expect(is_logged_in?).to be_truthy
    end
    it "current_user returns nil when remember digest is wrong" do
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to eq nil
    end
  end
end
