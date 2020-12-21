# FactoryBotを定義する
FactoryBot.define do
  # Micropostのファクトリを作成する
  factory :micropost do
    content { "micropost test" }
    created_at { 10.minutes.ago }
    association :user

    trait :yesterday do
      content { "yesterday" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      content { "day_before_yesterday" }
      created_at { 2.days.ago }
    end

    trait :now do
      content { "now!" }
      created_at { Time.zone.now }
    end
  end
end
