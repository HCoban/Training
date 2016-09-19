class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.username}: account created"
      login(@user)
      redirect_to user_url(@user.id)
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
        flash[:errors] = "You cannot view that page"
        redirect_to user_url(@user.id)
      end
    else
      flash[:errors] = "Please log in"
      redirect_to new_session_url
    end
  end

  def edit
    @user = current_user
    unless current_user.id == params[:id].to_i
      redirect_to user_url(current_user.id)
    else
      render :edit
    end
  end

  def update
    @user = current_user
    if BCrypt::Password.new(current_user.password_digest).is_password?(params[:user][:old_password])
      @user.update_attributes(user_params)
      if @user.valid?
        @user.password= params[:user][:new_password]
        @user.save
        flash[:success] = "#{@user.username}: account updated"
        render :show
      else
        flash[:errors] = "User could not be updated"
        render :edit
      end
    else
      flash[:errors] = "Old password did not match account"
      redirect_to edit_user_path
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
