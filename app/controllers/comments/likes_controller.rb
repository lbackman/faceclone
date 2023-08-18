class Comments::LikesController < ApplicationController
  include Likeable
  before_action :set_likeable, :set_parent

  private

    def set_likeable
      @likeable = Comment.find(params[:comment_id])
    end

    def set_parent
      @parent = @likeable.commentable
    end
end
