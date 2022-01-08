require "rails_helper"

RSpec.describe Users::IdentitiesPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :destroy? do
    it "allows users to remove connected identity" do
      expect(subject).to permit(user, nil)
    end
  end
end
