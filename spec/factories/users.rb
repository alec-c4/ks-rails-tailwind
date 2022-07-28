FactoryBot.define do
  factory :user, aliases: %i[author commenter owner recipient] do
    first_name { "Steve" }
    last_name { "Jobs" }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    confirmed_at { Time.zone.now }
    time_zone { Time.zone.name }

    factory :admin do
      email { FFaker::Internet.email }
      password { FFaker::Internet.password }
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
