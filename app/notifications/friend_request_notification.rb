# To deliver this notification:
#
# FriendRequestNotification.with(friend_request: @friend_request).deliver_later(friend_request.receiver)
# FriendRequestNotification.with(post: @post).deliver(current_user)

class FriendRequestNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :friend_request

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", sender: User.find(params[:friend_request][:sender_id]).first_name)
  end
  #
  def url
    user_path(User.find(params[:friend_request][:sender_id]))
  end
end
