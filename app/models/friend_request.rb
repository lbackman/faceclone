class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  after_create_commit :notify_receiver
  has_noticed_notifications # removes notification when deleting friend request

  validates :sender_id, :receiver_id,
            presence: true,
            unique_friend_request: true, on: :create

  validates :sender_id, comparison: { other_than: :receiver_id }

  scope :sent, ->(user) { FriendRequest.where(sender: user, accepted: false) }
  scope :received, ->(user) { FriendRequest.where(receiver: user, accepted: false) }
  scope :mutual, ->(user_1, user_2) {
    FriendRequest.where(
      sender:   [user_1, user_2],
      receiver: [user_1, user_2]) }

  private

  def notify_receiver
    FriendRequestNotification.with(friend_request: self).deliver_later(receiver)
  end
end
