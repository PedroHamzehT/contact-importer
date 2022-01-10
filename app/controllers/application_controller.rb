class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate_user!
    redirect_to '/sessions/new' unless session[:user_id]
  end

  def user_authenticated!
    redirect_to '/contacts' if session[:user_id]
  end
end
