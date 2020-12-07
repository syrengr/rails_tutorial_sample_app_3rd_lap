# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：RailsチュートリアルのテストをRspecで書いてみた[第10章]
RSpec.describe "sessions", type: :request do
  # userファクトリを作成する
  let(:user) { FactoryBot.create(:user) }
  # フレンドリーフォワーディングのテスト
  describe "friendly forwarding" do
    # 成功した場合
    # it "succeeds" do
    #   # HTTPリクエストgetでedit_userページを開く
    #   get edit_user_path(user)
    #   # log_in_as(user)を呼び出す
    #   log_in_as(user)
    #   # edit_userページへリダイレクトすることを期待する
    #   expect(response).to redirect_to edit_user_url(user)
    # end
  end
end
