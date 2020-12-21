# rails_helperを読み込む
require "rails_helper"

# Relationshipモデルのバリデーションをテストする
RSpec.describe Relationship, type: :model do
  # バリデーションのテスト
  describe "validation" do
    # ファクトリ作成
    let(:user) { FactoryBot.create(:user) }
    # ファクトリ作成
    let(:other_user) { FactoryBot.create(:user) }
    # ファクトリ作成
    let(:relationship) { user.active_relationships.build(followed_id: other_user.id) }

    # 有効なテストデータ
    it "is valid with test data" do
      # 有効であることを期待する
      expect(relationship).to be_valid
    end

    # 存在性のテスト
    describe "presence" do
      # 無効なfollower_id
      it "is invalid without follower_id" do
        # relationship.follower_id定義
        relationship.follower_id = nil
        # 無効であることを期待する
        expect(relationship).to be_invalid
      end
      # 無効なfollowed_id
      it "is invalid without followed_id" do
        # relationship.followed_id定義
        relationship.followed_id = nil
        # 無効であることを期待する
        expect(relationship).to be_invalid
      end
    end
  end
end
