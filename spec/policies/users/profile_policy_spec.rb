require "rails_helper"

RSpec.describe Users::ProfilePolicy, type: :policy do
  subject { described_class.new(user, nil) }

  context "being a registered user" do
    let(:user) { create(:user) }

    it { should permit_edit_and_update_actions }
  end

  context "being a admin user" do
    let(:user) { create(:admin) }

    it { should permit_edit_and_update_actions }
  end
end
