class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :configure_time_zone, if: :current_user

  add_flash_types :notice, :success, :alert, :error

  impersonates :user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  ### Devise

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name time_zone])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name time_zone])
  end

  def after_sign_in_path_for(resource)
    set_flash_message! :alert, :warn_pwned if resource.respond_to?(:pwned?) && resource.pwned?
    super
  end

  private

  def append_info_to_payload(payload)
    super
    payload[:user_id] = signed_in? ? current_user.id : "guest"
  end

  def user_not_authorized
    flash[:alert] = t("application.access_denied")
    redirect_to root_path
  end

  ### TimeZone

  def browser_time_zone
    browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:timezone])
    ActiveSupport::TimeZone.all.find { |zone| zone.tzinfo == browser_tz } || Time.zone
  rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
    Time.zone
  end

  helper_method :browser_time_zone

  def configure_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block) if signed_in? && current_user.time_zone.present?
  end

  ### i18n

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale] || cookies[:locale]
    if parsed_locale&.empty? && request.env["HTTP_ACCEPT_LANGUAGE"].present?
      parsed_locale = request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/)[0]
    end

    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil

    cookies[:locale] = parsed_locale unless cookies[:locale] && cookies[:locale] == parsed_locale

    parsed_locale
  end
end
