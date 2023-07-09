class UserInformationsController < ApplicationController
  before_action :set_user, :set_user_information

  def edit
  end

  def update
    if @user_information.update(editable_user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def set_user_information
      @user_information = @user.user_information
    end

    def editable_user_params
      params.require(:user_information).permit(:hometown, :about_me)
    end
end
