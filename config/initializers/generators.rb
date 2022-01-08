Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
  g.helper false
  g.test_framework :rspec,
    fixtures: false,
    view_specs: false,
    helper_specs: false
end
