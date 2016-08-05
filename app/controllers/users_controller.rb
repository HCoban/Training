class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.username}: account created"
      login(@user)
      render :show
    else
      flash[:errors] = "User could not be created"
      render :new
    end
  end

  def show
    @user = current_user
    if logged_in?
      if current_user.id == params[:id].to_i
        render :show
      else
        redirect_to new_session_url
      end
    else
      flash[:errors] = "Please log in"
      redirect_to new_session_url
    end
  end

  def edit
    render :edit
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "#{@user.username}: account updated"
      render :show
    else
      flash[:errors] = "User could not be updated"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      flash[:success] = "User has been destroyed"
      redirect_to new_user_url
    else
      flash[:errors] = "User is invencible"
      render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
