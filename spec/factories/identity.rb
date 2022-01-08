FactoryBot.define do
  factory :identity do
    uid { "test_#{rand(0...9999999)}" }
    provider { "google" }
    association :user
  end
end
