# rails_helperを読み込む
require "rails_helper"

# Micropostsコントローラの認可テスト
RSpec.describe "Microposts", type: :request do
  # createメソッドのテスト
  describe "Microposts#create" do
    # 遅延評価
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    # 遅延評価
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    # loginできなかった場合を検証する
    context "when not logged in" do
      # micropost数を変更できないことを検証する
      it "doesn't change Micropost's count" do
        # micropost数が0件であることを期待する
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      # loginページへリダイレクトすることを検証する
      it "redirects to login_url" do
        # loginページへリダイレクトすることを期待する
        expect(post_request).to redirect_to login_url
      end
    end
  end

  # destroyメソッドのテスト
  describe "Microposts#destroy" do
    # 遅延評価
    let!(:micropost) { FactoryBot.create(:micropost) }
    # 遅延評価
    let(:delete_request) { delete micropost_path(micropost) }

    # loginできなかった場合を検証する
    context "when not logged in" do
      # micropost数を変更できないことを検証する
      it "doesn't change Micropost's count" do
        # micropost数が0件であることを期待する
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      # loginページへリダイレクトすることを検証する
      it "redirects to login_url" do
        # loginページへリダイレクトすることを期待する
        expect(delete_request).to redirect_to login_url
      end
    end
  end

  # 間違ったuserによるmicropost削除に対してテストする
  context "when logged in user tyies to delete another user's micropost" do
    # 遅延評価
    let(:user) { FactoryBot.create(:user) }
    # 前処理
    before { log_in_as(user) }

    # micropost数が変更しない場合を検証する
    it "doesn't chnage Micropost's count" do
      # micropost数が0件であることを期待する
      expect { delete_request }.to change(Micropost, :count).by(0)
    end

    # rootページへリダイレクトすることを検証する
    it "redirects to root_url" do
      # rootページへリダイレクトすることを期待する
      expect(delete_request).to redirect_to root_url
    end
  end
end
