require "rails_helper"

RSpec.describe Customer::DashboardPolicy, type: :policy do
  let(:user) { User.new }
  subject { described_class }

  permissions :index? do
    it "allows users to access dashboard" do
      expect(subject).to permit(user, nil)
    end
  end
end
