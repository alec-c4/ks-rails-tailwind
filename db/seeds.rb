USERS_TO_CREATE = 50

ActiveJob::Base.queue_adapter = :inline
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = false

Dir[Rails.root.join("db", "seeds", "*.rb")].sort.each do |file|
  require file
end
