class Admin::RolesController < Admin::BaseController
  before_action :setup

  def create
    respond_to do |format|
      if @role.nil?
        format.html { redirect_to admin_user_url(@user), alert: "Cannot add role" }
      else
        @user.add_role @role
        format.html { redirect_to admin_user_url(@user), notice: "Role added" }
      end

      format.json { head :no_content }
    end
  end

  def destroy
    respond_to do |format|
      if @role.nil?
        format.html { redirect_to admin_user_url(@user), alert: "Cannot remove role" }
        format.turbo_stream { redirect_to admin_user_url(@user), alert: "Cannot remove role", status: :see_other }
      else
        @user.remove_role @role
        format.html { redirect_to admin_user_url(@user), notice: "Role removed" }
        format.turbo_stream { redirect_to admin_user_url(@user), notice: "Role removed", status: :see_other }
      end

      format.json { head :no_content }
    end
  end

  private

  def setup
    @user = User.find(params[:user_id])

    role_param = params[:role_name] || params[:role][:role_name]

    @role = (role_param.to_sym if Role::ALLOWED_GLOBAL_ROLES.include? role_param.to_sym)
  end
end
