class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_current_user

  def set_current_user
    Thread.current[:current_user] = current_user
  end

  def after_sign_in_path_for(resource_or_scope) # needed since devise route set to root
    artists_path
  end
end
