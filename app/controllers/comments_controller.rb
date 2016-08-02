class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.post = @post
    @comment.save!

    respond_to do |format|
      format.html { redirect_to @comment }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :body)
  end
end
