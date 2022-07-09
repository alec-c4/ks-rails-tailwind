# You can setup your Rails state here
# MyModel.create name: 'something'
User.create!(
  first_name: FFaker::Name.first_name,
  last_name: FFaker::Name.last_name,
  email: "user@example.com",
  password: "user@example.com",
  time_zone: Time.zone.name,
  confirmed_at: Time.zone.now
)

admin = User.create!(
  first_name: FFaker::Name.first_name,
  last_name: FFaker::Name.last_name,
  email: "admin@example.com",
  password: "admin@example.com",
  time_zone: Time.zone.name,
  confirmed_at: Time.zone.now
)

admin.add_role :admin