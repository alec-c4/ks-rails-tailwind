FactoryBot.define do
  factory :user, aliases: %i[author commenter] do
    first_name { "Steve" }
    last_name { "Jobs" }
    email { "user@example.com" }
    password { "user@example.com" }
    confirmed_at { Time.zone.now }
    time_zone { Time.zone.name }

    factory :admin do
      email { "admin@example.com" }
      password { "admin@example.com" }
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
