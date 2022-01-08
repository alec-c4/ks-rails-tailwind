FactoryBot.define do
  factory :user, aliases: %i[author commenter] do
    first_name { "Steve" }
    last_name { "Jobs" }
    email { "user@cosmoport.co" }
    password { "user@cosmoport.co" }
    confirmed_at { Time.zone.now }
    time_zone { Time.zone.name }

    factory :admin do
      email { "admin@cosmoport.co" }
      password { "admin@cosmoport.co" }
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
