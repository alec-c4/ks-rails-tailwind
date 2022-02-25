# frozen_string_literal: true

class Elements::FlashComponent < ViewComponent::Base
  def initialize
    @flash_class = {
      notice: "alert alert-info",
      success: "alert alert-success",
      error: "alert alert-danger",
      alert: "alert alert-warning"
    }
  end
end
