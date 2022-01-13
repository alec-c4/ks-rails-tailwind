require "rails_helper"

RSpec.describe Elements::FlashComponent, type: :component do
  it "renders flash notification" do
    with_controller_class Customer::DashboardController do
      controller.flash[:notice] = "Notification message!"
      render_inline described_class.new()
    end

    expect(rendered_component).to have_text "Notification message!"
    expect(rendered_component).to have_selector "label"
    expect(rendered_component).not_to have_selector "img"
  end
end
