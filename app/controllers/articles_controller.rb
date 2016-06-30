class ArticlesController < ApplicationController
  include ArticlesHelper
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article_id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_email = current_user.email
    @article.save

    flash.notice = "Article '#{@article.title}' Created!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' Deleted!"

    redirect_to action: "index"
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_filter :current_user_rights?, only: [:edit, :update, :destroy]

  def current_user_rights?
    @article = Article.find(params[:id])
    unless @article.author_email == current_user.email
      flash.notice = "You are not the owner of this article!"
      redirect_to article_path(@article)
      return false
    end
  end


end
