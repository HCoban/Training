class SessionsController < ApplicationController
  before_action :redirect

  def new
    UsersController.new
  end

  def create
    user = User.new(user_params)
    if user
      user.save
      @current_user = user
    end
    # User.find_by_credentials(self.user_name, self.password)
    if @current_user
      login_user!
      redirect_to cat_url(@current_user.id)
    else

      user.errors[:user] << "Invalid credentials"
      redirect_to new_user_url
    end
  end

  def destroy
    logout_user!
  end

  def redirect
    if @current_user
      redirect_to :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
