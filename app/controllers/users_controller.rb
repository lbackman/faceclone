class UsersController < ApplicationController
  def index
    index_users = User
                  .search(params[:search])
                  .includes(:user_information, avatar_attachment: :blob)
                  .order(:created_at)
    @users = {}
    index_users.each do |user|
      @users[user] = FriendRequest.mutual(user, current_user) || FriendRequest.new
    end

    @users.each do |_user, friend_request|
      mark_friend_request_notifications_as_read(friend_request)
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @friend_request = FriendRequest.mutual(current_user, @user) || FriendRequest.new
    if current_user == @user || current_user.friends_with?(@user)
      @posts = Post.where(author: @user).with_author_information.order(created_at: :desc)
    else
      @posts = Post.where(author: nil)
    end

    mark_friend_request_notifications_as_read(@friend_request)
  end

  def friends
    @user = User.find_by_id(params[:id])
    @friends = User.friends(@user).search(params[:search]).includes(:user_information, avatar_attachment: :blob)
  end

  def purge_avatar
    @user = User.find_by_id(params[:id])
    @user.avatar.purge
    redirect_back(fallback_location: user_path(@user), notice: "Avatar removed")
  end

  private

    def mark_friend_request_notifications_as_read(friend_request)
      if friend_request.receiver == current_user
        mark_notifications_as_read(
          friend_request.notifications_as_friend_request.where(recipient: current_user)
        )
      end
    end
end
