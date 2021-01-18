# FactoryBotを定義する
FactoryBot.define do
  # # Relationshipモデルのファクトリを作成する
  factory :relationship do
    # follower_idに1を代入する
    follower_id { 1 }
    # follower_idに1を代入する
    followed_id { 1 }
  end
end
