class SessionsController < ApplicationController
  before_action :user_authenticated!, only: %i[new create]
  before_action :authenticate_user!, only: %i[logout]

  def new; end

  def create
    @user = User.find_by(username: session_params[:username])

    unless @user
      @error = 'Invalid username or password'
      return render :new
    end

    if @user.authenticate(session_params[:password])
      session[:user_id] = @user.id

      redirect_to '/contacts'
    else
      @error = 'Invalid username or password'
      render :new
    end
  end

  def logout
    session.delete(:user_id)

    redirect_to '/users/new'
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
