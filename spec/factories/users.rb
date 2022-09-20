FactoryBot.define do
  factory :user, aliases: %i[author commenter owner recipient] do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { FFaker::Internet.password }
    confirmed_at { Time.zone.now }
    time_zone { FFaker::Address.time_zone }

    factory :admin do
      email { FFaker::Internet.email }
      password { FFaker::Internet.password }
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
