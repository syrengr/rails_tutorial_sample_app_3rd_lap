# FactoryBotを定義する
FactoryBot.define do
  # Userモデルのファクトリを作成する
  factory :user do
    # nameのテストデータを作成する
    name { "Example User" }
    # emailのテストデータを作成する
    sequence(:email) { |n| "user_#{n}@example.com" }
    # passwordのテストデータを作成する
    password { "password" }
    # passwordの確認用テストデータを作成する
    password_confirmation { "password" }
  end
end
