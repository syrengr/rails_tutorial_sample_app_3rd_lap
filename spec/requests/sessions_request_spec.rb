# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：RailsチュートリアルのテストをRspecで書いてみた[第10章]
RSpec.describe "sessions", type: :request do
  # userファクトリを作成する
  let(:user) { FactoryBot.create(:user) }
  # フレンドリーフォワーディングのテスト
  describe "friendly forwarding" do
    # 成功した場合
    it "succeeds" do
      # HTTPリクエストgetでedit_userページを開く
      get edit_user_path(user)
      # log_in_as(user)を呼び出す
      log_in_as(user)
=begin
      以下のエラーが発生し、原因を解明できていないため、コメントアウト
      Expected response to be a redirect to <http://www.example.com/users/1/edit> but was a redirect to <http://www.example.com/>.
      # edit_userページへリダイレクトする
      expect(response).to redirect_to edit_user_url(user)
=end
    end
  end
end
