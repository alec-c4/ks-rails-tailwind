require "rails_helper"

RSpec.describe Identity, type: :model do
  subject(:identity) { described_class.new }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:provider) }
  end
end
