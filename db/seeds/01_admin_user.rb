if User.count == 0
  puts "Create admin user"

  admin = User.create!(
    first_name: "Super",
    last_name: "Admin",
    email: "admin@example.com",
    password: "admin@example.com",
    time_zone: Time.zone.name
  )

  admin.confirm
  admin.add_role :admin
end
