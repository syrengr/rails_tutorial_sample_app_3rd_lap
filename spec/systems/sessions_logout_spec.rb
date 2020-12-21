# rails_helperを読み込む
require "rails_helper"

# sessionsのテストをする
RSpec.describe "sessions", type: :system do
  # 前処理
  before do
    # logoutページを開く
    visit logout_path
  end
end
