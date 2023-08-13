class CommentsController < ApplicationController
  before_action :set_comment

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def set_comment
      # @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
