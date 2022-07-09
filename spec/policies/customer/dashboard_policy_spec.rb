require "rails_helper"

RSpec.describe Customer::DashboardPolicy, type: :policy do
  subject { described_class.new(user, nil) }

  context "being a registered user" do
    let(:user) { create(:user) }

    it { should permit_action :index }
  end

  context "being a admin user" do
    let(:user) { create(:admin) }

    it { should permit_action :index }
  end
end
