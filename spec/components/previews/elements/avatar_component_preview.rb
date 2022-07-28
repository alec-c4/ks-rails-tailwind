class Elements::AvatarComponentPreview < ViewComponent::Preview
  # @label Square
  #

  # @param preset [Symbol] select [[Thumb, thumb], [Medium, medium], [Large, large]]]
  # @param geometry [Symbol] select [[Square, square], [Rounded, rounded], [Circle, circle]]
  def default(user: User.first, preset: :thumb, geometry: :square)
    render Elements::AvatarComponent.new(user: user, preset: preset, geometry: geometry)
  end
end
