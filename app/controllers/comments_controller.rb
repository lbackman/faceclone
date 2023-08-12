class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user
    
    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment_form', partial: 'comments/form', locals: { commentable: @commentable, comment: Comment.new }) }
        format.html { render partial: 'comments/form', locals: { commentable: @commentable, comment: Comment.new }}
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment_form', partial: 'comments/form', locals: { commentable: @commentable, comment: @comment }) }
        format.html { render partial: 'comments/form', locals: { commentable: @commentable, comment: @comment }}
      end
    # redirect_back(fallback_location: @commentable)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
