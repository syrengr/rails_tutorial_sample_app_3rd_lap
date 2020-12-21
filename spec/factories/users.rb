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

  # 管理者権限の制御テスト用データ
  trait :admin do
    # 管理者をtrueにする
    admin { true }
  end

  # アカウント有効化テスト用データ
  trait :no_activated do
    # 論理値をfalseに設定する
    activated { false }
    # 論理値をnilに設定する
    activated_at { nil }
  end
end
