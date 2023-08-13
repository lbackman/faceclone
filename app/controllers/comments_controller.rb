class CommentsController < ApplicationController
  before_action :set_comment

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    commentable = @comment.commentable
    @comment.destroy

    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_back(fallback_location: commentable) }
    end
  end

  private

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
