class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(post: @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
