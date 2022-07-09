require "rails_helper"

RSpec.describe Role, type: :model do
  subject(:role) { described_class.new }

  describe "associations" do
    it { should have_and_belong_to_many(:users) }
    it { should belong_to(:resource).optional }
  end

  describe "validations" do
    it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types) }
    it { should allow_value(nil).for(:resource_type) }
  end
end
