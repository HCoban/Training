class PostsController < ApplicationController

  def new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:success] = "#{@post.title} has been created"
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = "Post could not be created"
      render :new
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    render :show
  end

  def edit
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    if current_user.id == @post.author_id && @post.update(post_params)
      flash[:success] = "#{@post.title} updated"
      redirect_to post_url(@post.id)
    else
      flash[:errors] = "#{@post.title} could not be updated"
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if current_user.id == @post.author_id && @post.destroy
      flash[:success] = "Post destroyed"
      redirect_to sub_url(@post.sub.id)
    else
      flash[:errors] = "#{@post.title} lives on"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
