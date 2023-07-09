class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]
  before_action :set_user, only: :index

  def index
    @sent_friend_requests = FriendRequest.sent(@user)
    @received_friend_requests = FriendRequest.received(@user)
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    @other_user = User.find_by_id(@friend_request.receiver_id)

    if @friend_request.save
      respond_to do |format|
        format.html { redirect_to user_path(@other_user), notice: "Friend request sent to #{@other_user.first_name}." }
        format.turbo_stream { flash.now[:notice] = "Friend request sent to #{@other_user.first_name}." }
      end
    else
      redirect_to user_path(@other_user),
        status: :unprocessable_entity,
        alert: "Friend request could not be sent to #{@other_user.first_name}."
    end
  end

  def update
    # First check if the friend request exists
    if @friend_request && @friend_request.update(accepted: true)
      respond_to do |format|
        @other_user = @friend_request.sender
        format.html { redirect_to user_path(@other_user), notice: "Friend request accepted." }
        format.turbo_stream { flash.now[:notice] = "Friend request accepted." }
      end
    else
      redirect_back_or_to root_path,
        status: :unprocessable_entity,
        alert: "The friend request does not seem to exist."
    end
  end

  def destroy
    @other_user = User.find_by_id(
      [@friend_request.sender_id, @friend_request.receiver_id]
        .select { |id| id != current_user.id }.first.to_i
    ) if @friend_request
    if @friend_request && @friend_request.destroy
      respond_to do |format|
        # Should say "Friendship declined", if declining, and "#{name} unfriended" if already friends
        format.html { redirect_to user_path(@other_user), notice: "Friendship deleted." }
        format.turbo_stream { flash.now[:notice] = "Friendship deleted." }
      end
    else
      redirect_back_or_to root_path,
        status: :unprocessable_entity,
        alert: "The friendship does not seem to exist."
    end
  end

  private

    def set_friend_request
      @friend_request = FriendRequest.find_by_id(params[:id])
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      render_access_denied unless @user == current_user
    end

    def friend_request_params
      params.require(:friend_request).permit(:sender_id, :receiver_id)
    end
end
