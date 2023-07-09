class UsersController < ApplicationController
  def index
    @users = User.all.includes(:user_information)
  end

  def show
    @user = User.find_by_id(params[:id])
    @friend_request = FriendRequest.mutual(current_user, @user).first || FriendRequest.new
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
    @friends = User.friends(@user).includes(:user_information)
  end
end
