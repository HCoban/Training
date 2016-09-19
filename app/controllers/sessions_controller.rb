class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      if login(@user)
        flash[:success] = "#{@user.username}: Logged In"
        redirect_to user_url(@user.id)
      end
    else
      flash[:errors] = "login unsuccessful"
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    session[:session_token] = nil
    current_user = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
