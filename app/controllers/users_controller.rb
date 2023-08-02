class UsersController < ApplicationController
  def index
    @users = User.includes(:user_information, avatar_attachment: :blob).order(:created_at)
    id = current_user.id
    @friend_requests = FriendRequest.where("friend_requests.receiver_id = ? OR friend_requests.sender_id = ?", id, id)
  end

  def show
    @user = User.find_by_id(params[:id])
    @friend_request = FriendRequest.mutual(current_user, @user) || FriendRequest.new
    if current_user == @user || current_user.friends_with?(@user)
      @posts = Post.where(author: @user).with_author_information.order(created_at: :desc)
    else
      @posts = Post.where(author: nil)
    end

    if @user != current_user && @friend_request.created_at
      mark_notifications_as_read(@friend_request.notifications_as_friend_request.where(recipient: current_user))
    end
  end

  def friends
    @user = User.find_by_id(params[:id])
    @friends = User.friends(@user).includes(:user_information, avatar_attachment: :blob)
  end

  def purge_avatar
    @user = User.find_by_id(params[:id])
    @user.avatar.purge
    redirect_back(fallback_location: user_path(@user), notice: "Avatar removed")
  end
end
