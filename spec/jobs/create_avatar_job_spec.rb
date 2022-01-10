require 'rails_helper'

RSpec.describe CreateAvatarJob, type: :job do
  let(:user) { create(:user) }

  describe "#perform_later" do
    it "creates an avatar" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateAvatarJob.perform_later(user)
      }.to have_enqueued_job
    end
  end
end
