require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { described_class.new }

  describe "associations" do
    it { is_expected.to belong_to(:recipient) }
  end
end
