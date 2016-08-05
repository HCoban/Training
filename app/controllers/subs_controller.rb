class SubsController < ApplicationController

  before_action :ensure_moderator_status, only: :edit
  def ensure_moderator_status
    if current_user
      @sub = Sub.find_by_id(params[:id])
      current_user.id == @sub.moderator_id
    else
      flash[:errors] = "You ain't no hacker"
      redirect_to new_session_path
    end
  end

  def new
    if logged_in?
      @sub = Sub.new
      render :new
    else
      flash[:errors] = "You must be logged in to create a sub"
      redirect_to new_session_path
    end
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:success] = "#{@sub.title} created!"
      redirect_to sub_url(@sub.id)
    else
      flash[:errors] = "#{@sub.title} could not be created"
      render :new
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

  def destroy
    @sub = Sub.find_by_id(params[:id])
    if logged_in? && @sub.moderator_id == current_user.id
      if @sub.destroy
        flash[:success] = "The Sub has been destroyed"
        redirect_to subs_url
      else
        flash[:errors] = "This sub could not be destroyed"
        redirect_to sub_url(@sub.id)
      end
    else
      flash[:errors] = "You can't destroy this sub"
      redirect_to sub_url(@sub.id)
    end
  end

  def edit
    render :edit
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update(sub_params)
      flash[:success] = "#{@sub.title} has been updated!"
      redirect_to sub_url(@sub.id)
    else
      flash[:errors] = "#{@sub.title} could not be updated."
      redirect_to edit_sub_path
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
