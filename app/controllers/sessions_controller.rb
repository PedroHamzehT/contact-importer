class SessionsController < ApplicationController
  before_action :user_authenticated!

  def new; end

  def create
    @user = User.find_by(username: session_params[:username])

    unless @user
      @error = 'User not found!'
      render :new
    end

    if @user.authenticate(session_params[:password])
      session[:user_id] = @user.id

      redirect_to '/contacts'
    else
      @error = 'Incorrect password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to '/users/new'
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
