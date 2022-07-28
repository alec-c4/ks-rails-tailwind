# frozen_string_literal: true

class Elements::AvatarComponent < ViewComponent::Base
  def initialize(user: nil, preset: :thumb, geometry: :square)
    @user = user
    @preset = preset
    classes = []

    case geometry
    when :square
      classes << "rounded-none"
    when :rounded
      classes << "rounded-lg"
    when :circle
      classes << "rounded-full"
    else
      raise ArgumentError, "Invalid geometry: #{geometry}"
    end

    case preset
    when :thumb
      classes << "h-24 w-24"
      @width = "100px"
      @height = "100px"
    when :medium
      classes << "h-48 w-48"
      @width = "200px"
      @height = "200px"
    when :large
      classes << "h-64 w-64"
      @width = "300px"
      @height = "300px"
    else
      raise ArgumentError, "Invalid preset: #{preset}"
    end

    @classes = classes.join(" ")
  end
end
