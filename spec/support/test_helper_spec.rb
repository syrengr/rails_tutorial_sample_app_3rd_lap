# rails_helperを読み込む
require "rails_helper"

# moduleの引用元：RailsチュートリアルのテストをRspecで書いてみた[第9章]
module TestHelper
  # user登録後のloginのテスト用メソッド
  def is_logged_in?
    # sessionのuser_idはnilではない
    !session[:user_id].nil?
  end

  # [remember me]チェックボックスのテスト用メソッド
  def log_in_as(user, remember_me: "1")
    # emailからremember_meキーとバリューをsessionキーとparamsに代入し、loginメソッドへpostリクエストする
    post login_path, params: { session: { email:       user.email,
                                          password:    user.password,
                                          remember_me: remember_me } }
  end
end

# moduleの引用元：RailsチュートリアルのテストをRspecで書いてみた[第9章]
RSpec.configure do |config|
  # TestHelperモジュールを読み込む
  config.include TestHelper
end
