# FactoryBotを定義する
FactoryBot.define do
  # Relationshipのファクトリを作成する
  factory :relationship do
    follower_id { 1 }
    followed_id { 1 }
  end
end
