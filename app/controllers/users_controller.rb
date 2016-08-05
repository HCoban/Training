class UsersController < ApplicationController
  before_action :redirect

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login_user!
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
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
