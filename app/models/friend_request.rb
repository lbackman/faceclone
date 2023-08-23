class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  after_create_commit :notify_receiver
  after_update_commit :delete_notification
  has_noticed_notifications # removes notification when deleting friend request

  validates :sender_id, :receiver_id,
            presence: true,
            unique_friend_request: true, on: :create

  validates :sender_id, comparison: { other_than: :receiver_id }

  scope :sent, ->(user) {
    FriendRequest
      .includes(receiver: [:user_information, avatar_attachment: :blob])
      .where(sender: user, accepted: false) }

  scope :received, ->(user) {
    FriendRequest
    .includes(sender: [:user_information, avatar_attachment: :blob])
    .where(receiver: user, accepted: false) }

  def self.mutual(user_1, user_2)
    FriendRequest.find_by(sender: [user_1, user_2], receiver: [user_1, user_2])
  end

  def self.sent_or_received(user, direction)
    case direction
    when "sent"
      FriendRequest.sent(user)
    else
      FriendRequest.received(user)
    end
  end

  private

  def notify_receiver
    FriendRequestNotification.with(friend_request: self).deliver_later(receiver)
  end

  def delete_notification
    self.notifications_as_friend_request.first.destroy
  end
end
