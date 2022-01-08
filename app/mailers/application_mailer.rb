class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.default_from
  layout "mailer"
end
