if User.count < 2000

  progressbar = ProgressBar.create(
    title: "Create basic users",
    total: USERS_TO_CREATE
  )

  USERS_TO_CREATE.times do |i|
    user = User.create!(
      first_name: FFaker::NameRU.first_name,
      last_name: FFaker::NameRU.last_name,
      email: FFaker::Internet.safe_email,
      password: FFaker::Internet.safe_email,
      time_zone: Time.zone.name
    )

    user.confirm
    progressbar.increment
  end
end
