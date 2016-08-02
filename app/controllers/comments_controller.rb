class CommentsController < ApplicationController
  def create
    @comment = authorable.comments.new(comment_params)
    @comment.authorable = authorable
    @comment.save!

    respond_to do |format|
      format.html { redirect_to @comment }
      format.js
    end
  end

  private

  def authorable
    authorable_type.find(authorable_id)
  end

  def authorable_type
    Post if params[:post_id]
    Article if params[:article_id]
  end

  def authorable_id
    params[:post_id] || params[:article_id]
  end

  def comment_params
    params.require(:comment).permit(:user, :body)
  end
end
