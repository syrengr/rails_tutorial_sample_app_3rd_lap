# FactoryBotを定義する
FactoryBot.define do
  # Micropostモデルのファクトリを作成する
  factory :micropost do
    # マイクロポストの投稿内容
    content { "micropost test" }
    # マイクロポストの投稿時間
    created_at { 10.minutes.ago }
    # 関係するuserオブジェクトを自動的に作成する
    association :user

    # 昨日投稿したテスト用データ
    trait :yesterday do
      # マイクロポストの投稿内容
      content { "yesterday" }
      # マイクロポストの投稿時間
      created_at { 1.day.ago }
    end

    # 一昨日投稿したテスト用データ
    trait :day_before_yesterday do
      # マイクロポストの投稿内容
      content { "day_before_yesterday" }
      # マイクロポストの投稿時間
      created_at { 2.days.ago }
    end

    # 今投稿したテスト用データ
    trait :now do
      # マイクロポストの投稿内容
      content { "now!" }
      # マイクロポストの投稿時間
      created_at { Time.zone.now }
    end
  end
end
