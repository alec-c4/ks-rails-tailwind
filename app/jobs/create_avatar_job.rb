class CreateAvatarJob < ApplicationJob
  queue_as :default

  def perform(user)
    img = Avatarly.generate_avatar(user.name, size: 500)
    user.avatar.attach(io: StringIO.new(img), filename: 'avatar.png')
  end
end
