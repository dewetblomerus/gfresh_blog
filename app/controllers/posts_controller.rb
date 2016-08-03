class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to posts_path
  end

  def index
    @feed = Feed.new(authorables: Post.all, authorable_type: PostWithLatestComments)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(authorable: @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
