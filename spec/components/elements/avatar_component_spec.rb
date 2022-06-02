require "rails_helper"

RSpec.describe Elements::AvatarComponent, type: :component do
  let(:user) { create(:user) }

  it "renders placeholder for user without avatar" do
    render_inline described_class.new(user:)
    expect(rendered_content).to have_text "No user picture"
    expect(rendered_content).to have_selector "svg"
    expect(rendered_content).not_to have_selector "img"
  end
end
