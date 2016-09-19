class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    flash.now[:errors] = []
    if @user
      login_user!(@user)
      redirect_to user_url(@current_user.id)
    else
      flash.now[:errors] << "Login failed! Try again!"
      render :new
    end
  end

  def destroy
    logout_user
    if logged_in?
      flash.now[:errors] = ["Error"]
    else
      flash.now[:errors] = ["Logged out"]
    end
    render :new
  end
end
