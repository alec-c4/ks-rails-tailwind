class Users::IdentitiesController < Users::BaseController
  before_action :set_identity, only: %i[destroy]

  def destroy
    authorize %i[users identities], :destroy?
    ahoy.track "Destroy identity", identity: @identity.provider
    @identity.destroy!
    redirect_back fallback_location: root_url
  end

  private

  def identity_params
    params.permit(:provider)
  end

  def set_identity
    @identity = current_user.identities.find_by(provider: params[:provider])
  end
end
