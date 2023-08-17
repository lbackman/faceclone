class LikesController < ApplicationController
  def index
    if params[:post_id]
      @type = "Comment"
    else
      @type = "Post"
    end
    @likes = Like
              .where(likeable_type: @type, likeable_id: params[:id])
              .includes(user: [:user_information, avatar_attachment: :blob])
  end
end
