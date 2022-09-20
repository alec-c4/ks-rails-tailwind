require "action_mailer"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "simplecov"
require "pundit/rspec"
require "pundit/matchers"
require "view_component/test_helpers"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Capybara::RSpecMatchers, type: :component
  config.include ViewComponent::TestHelpers, type: :component
end

SimpleCov.start
