class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy impersonate]
  skip_before_action :check_admin, only: :stop_impersonating

  def index
    if params[:query].blank?
      @pagy, @users = pagy(User.order("created_at DESC"))
    else
      logger.debug("Search query: #{params[:query]}")
      @pagy, @users = pagy(User.search(params[:query]).order("created_at DESC"))
    end
  end

  def show
    @roles = @user.roles.includes([:resource]).order("created_at DESC")
    @login_activities = @user.login_activities.last(10)
  end

  def edit
  end

  def update
    @user.skip_reconfirmation!
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: "User info updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.discard
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "User deleted", status: :see_other }
      format.json { head :no_content }
    end
  end

  def impersonate
    impersonate_user(@user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :name, :gender, :birthday, :avatar, :time_zone)
  end
end
