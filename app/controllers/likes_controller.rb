class LikesController < ApplicationController
  def index
    if params[:post_id]
      @type = "Comment"
    else
      @type = "Post"
    end
    @likes = Like.where(likeable_type: @type, likeable_id: params[:id]).includes(user: [:user_information])
  end

  def create
    @like = current_user.likes.new(like_params)
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
