# frozen_string_literal: true

class Elements::AvatarComponent < ViewComponent::Base
  def initialize(user: nil, preset: :thumb, geometry: :square)
    @user = user
    @preset = preset

    @classes = class_names({
      "rounded-lg": geometry == :square,
      "rounded-full": geometry != :square,
      "h-24 w-24": preset == :thumb,
      "h-48 w-48": preset == :medium,
      "h-96 w-96": preset == :large
    })
    case @preset
    when :thumb
      @width = "100px"
      @height = "100px"
    when :medium
      @width = "300px"
      @height = "300px"
    end
  end
end
