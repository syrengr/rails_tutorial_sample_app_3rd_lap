# rails_helperを読み込む
require "rails_helper"

# Micropostモデルのバリデーションに対するテストをする
RSpec.describe Micropost, type: :model do
  # 遅延評価
  let(:micropost) { FactoryBot.create(:micropost) }

  # Micropostのテストデータで有効な場合を検証する
  it "is valid with micropost's test data" do
    # 有効であることを期待する
    expect(micropost).to be_valid
  end
  
  # user_idが無く無効な場合を検証する
  it "is invalid with no user_id" do
    # micropost.user_id
    micropost.user_id = nil
    # 無効であることを期待する
    expect(micropost).to be_invalid
  end

  # contentが無く無効な場合を検証する
  it "is invalid with no content" do
    # micropost.content
    micropost.user_id = nil
    # 無効であることを期待する
    expect(micropost).to be_invalid
  end

  # 文字数が141数で無効な場合を検証する
  it "is invalid with 141-letter mails" do
    # micropost.content
    micropost.content = "a" * 141
    # 無効であることを期待する
    expect(micropost).to be_invalid
  end

  # Micropostモデルの順序付けのテスト
  describe "Sort by latest" do
    # 遅延評価
    let!(:day_before_yesterday) { FactoryBot.create(:micropost, :day_before_yesterday) }
    # 遅延評価
    let!(:now) { FactoryBot.create(:micropost, :now) }
    # 遅延評価
    let!(:yesterday) { FactoryBot.create(:micropost, :yesterday) }

    # 最初のレコードが現在日時であることを期待する
    it "succeeds" do
      expect(Micropost.first).to eq now
    end
  end
end
