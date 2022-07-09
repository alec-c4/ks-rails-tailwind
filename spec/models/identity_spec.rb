require "rails_helper"

RSpec.describe Identity, type: :model do
  subject(:identity) { described_class.new }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }
  end
end
