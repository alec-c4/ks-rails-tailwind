class Users::RegistrationsController < Devise::RegistrationsController
  layout "application", only: :edit

  def build_resource(hash = {})
    super
    resource.time_zone = browser_time_zone&.name || Time.zone.name
  end
end
