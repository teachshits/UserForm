class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def session_user
    User.find_by_id(session[:user_id])
  end
end
