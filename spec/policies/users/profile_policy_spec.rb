require "rails_helper"

RSpec.describe Users::ProfilePolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :update?, :edit? do
    it "allows users to edit their profiles" do
      expect(subject).to permit(user, nil)
    end
  end
end
