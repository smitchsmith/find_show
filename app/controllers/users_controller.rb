class UsersController < ApplicationController
  def unsubscribe
    user = User.find_by(hashed_id: params[:id])
    user.update_attribute(:subscribed, false)

    redirect_to root_path
  end
end
