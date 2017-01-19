class CurrentUsersController < ApplicationController
  before_filter :set_user

  def show
    render :edit
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      redirect_to edit_current_user_url
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :subscribed)
  end
end
