class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user
    @comment.save
    redirect_back(fallback_location: @commentable)
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
