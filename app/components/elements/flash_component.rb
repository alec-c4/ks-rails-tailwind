# frozen_string_literal: true

class Elements::FlashComponent < ViewComponent::Base
  def initialize(*)
    super
  end

  def flash_class(level)
    case level
    when "notice"
      "alert alert-info"
    when "success"
      "alert alert-success"
    when "error"
      "alert alert-warning"
    when "alert"
      "alert alert-error"
    end
  end
end
