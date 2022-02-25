class Users::ProfilesController < Users::BaseController
  def edit
    authorize %i[users profile], :edit?
  end

  def update
    user = current_user
    authorize %i[users profile], :update?

    respond_to do |format|
      if user.update(profile_params)
        format.html { redirect_to edit_profile_path, notice: t(".action_successful") }
        format.json { render :show, status: :ok, location: user }
      else
        format.html {
          flash.now[:alert] = t(".action_failed")
          render :edit, status: :unprocessable_entity
        }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birthday, :avatar, :time_zone)
  end
end
