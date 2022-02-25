class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.settings.mailer_default_from_email
  layout "mailer"
end
