class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def show
    @goal = Goal.find_by(params[:id])
  end

  def edit
    @goal = Goal.find_by(params[:id])
  end

  def index
    @user = User.find_by(params[:user_id])
    @goals = @user.goals
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_goals_url(@goal.user_id)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find_by(params[:id])
    redirect_to user_goals_url(current_user) unless @goal
    if @goal.user_id == current_user.id
      if @goal.save
        redirect_to user_goals_url(@goal)
      else
        flash[:errors] = @goal.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["Cannot edit another user's goal"]
      redirect_to user_goals_url(current_user)
    end
  end


  private
  def goal_params
    params.require(:goal).permit(:name, :gstatus, :completed)
  end
end
