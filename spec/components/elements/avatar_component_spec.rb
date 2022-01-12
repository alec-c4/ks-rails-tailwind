require "rails_helper"

RSpec.describe Elements::AvatarComponent, type: :component do
  let(:user) { create(:user) }

  it "renders placeholder for user without avatar" do
    render_inline described_class.new(user: user)
    expect(rendered_component).to have_text "No user picture"
    expect(rendered_component).to have_selector "svg"
    expect(rendered_component).not_to have_selector "img"
  end
end
