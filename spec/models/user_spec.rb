require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { described_class.new }

  describe "associations" do
    it { should belong_to(:banned_by).class_name("User").optional }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name).on(:update) }
    it { should validate_presence_of(:last_name).on(:update) }
  end
end
