class Comments::LikesController < ApplicationController
  before_action :set_comment

  def update
    if @comment.liked_by?(Current.user)
      @comment.unlike(Current.user)
    else
      @comment.like(Current.user)
    end

    render partial: 'likes/likes', locals: { likeable: @comment, liker: Current.user, parent: @comment.commentable }
  end

  private

    def set_comment
      @comment = Comment.find(params[:comment_id])
    end
end
