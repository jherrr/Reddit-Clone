class PostsController < ApplicationController

  before_action :require_user!
  before_action :require_author!, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:error] = @post.errors.full_messages
      render :new
    end
  end

  def update
    begin
      @post = current_user.posts.update(params[:id], post_params)
      render post_url(@post)
    rescue
      flash[:error] = @post.errors.full_messages
      render :edit
    end

  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_url
  end

  private

  def require_author!
    @post = Post.find(params[:id])
    redirect_to user_url unless current_user.id == @post.author_id
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
