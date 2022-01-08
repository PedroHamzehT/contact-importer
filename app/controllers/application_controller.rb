class ApplicationController < ActionController::Base
  def authenticate_user!
    redirect_to '/users/new' unless session[:user_id]
  end

  def user_authenticated!
    redirect_to '/contacts' if session[:user_id]
  end
end
