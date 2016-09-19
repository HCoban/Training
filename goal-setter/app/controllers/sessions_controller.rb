class SessionsController < ApplicationController

 def create
  @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
  if @user
    login(@user)
    redirect_to user_goals_url(@user)
  else
    flash[:errors] = "Invalid credentials"
    render :new
  end
 end

 def new
   @user = User.new
 end

 def destroy
    logout
    redirect_to new_session_url
 end

end
