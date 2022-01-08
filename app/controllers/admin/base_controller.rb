class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :check_admin
  before_action :disable_cache

  private

  def check_admin
    raise Pundit::NotAuthorizedError unless signed_in? && current_user.is_admin?
  end

  def disable_cache
    expires_now
  end
end
