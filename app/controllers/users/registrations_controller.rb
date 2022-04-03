class Users::RegistrationsController < Devise::RegistrationsController
  include Utmable

  layout "application", only: :edit

  def build_resource(hash = {})
    super
    CreateAvatarJob.perform_now(resource) unless resource.avatar.present?
    resource.time_zone = browser_time_zone&.name || Time.zone.name
    utm_resource resource
  end

  def create
    super
    utm_clear_cookies
  end
end
