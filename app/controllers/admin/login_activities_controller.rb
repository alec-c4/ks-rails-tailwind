class Admin::LoginActivitiesController < Admin::BaseController
  def index
    @user = User.find(params[:user_id])
    @pagy, @login_activities = pagy @user.login_activities
  end

  def show
    @login_activity = LoginActivity.find(params[:id])
  end
end
