# rails_helperを読み込む
require "rails_helper"

# リレーションシップの基本的なアクセス制御に対するテスト
RSpec.describe "Relationships", type: :request do
  # createメソッドのテスト
  describe "Relationships#create" do
    # 遅延処理
    let(:post_request) { post relationships_path }
    # ログインできなかった場合
    context "when not logged in" do
      # リレーションシップ数が変更しないことを検証する
      it "doesn't change Relationship's count" do
        # リレーションシップ数が0件であることを期待する
        expect { post_request }.to change(Relationship, :count).by(0)
      end
      # loginページへリダイレクトする場合
      it "redirects to login_url" do
        # loginページへリダイレクトすることを期待する
        expect(post_request).to redirect_to login_url
      end
    end
  end

  # destroyメソッドのテスト
  describe "Relationships#destroy" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # ファクトリ作成
    let(:other_user) { FactoryBot.create(:user) }
    # ファクトリ作成
    let(:delete_request) { delete relationship_path(other_user) }
    # 前処理
    before { user.following << other_user }
    # ログインできなかった場合
    context "when not logged in" do
      # リレーションシップ数が変更しないことを検証する
      it "doesn't change Relationship's count" do
        # リレーションシップ数が0件であることを期待する
        expect { delete_request }.to change(Relationship, :count).by(0)
      end
      # loginページへリダイレクトする場合
      it "redirects to login_url" do
        # loginページへリダイレクトすることを期待する
        expect(delete_request).to redirect_to login_url
      end
    end
  end
end
