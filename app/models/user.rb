class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Friendships as sender
  has_many :sent_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :sender_id,
           dependent: :destroy

  # Friendships as receiver
  has_many :received_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :receiver_id,
           dependent: :destroy    

  scope :friends, ->(user) do
    User.where(
      id: [
        *FriendRequest.where(sender: user, accepted: true).pluck(:receiver_id),
        *FriendRequest.where(receiver: user, accepted: true).pluck(:sender_id)
      ]
    )
  end

  def friends_with?(other_user)
    FriendRequest.exists?(
      sender_id:   [self.id, other_user.id],
      receiver_id: [other_user.id, self.id],
      accepted:    true
    )
  end

  def sent_friend_request_to?(other_user)
    FriendRequest.exists?(
      sender_id:   self.id,
      receiver_id: other_user.id,
      accepted:    false
    )
  end

  def received_friend_request_from?(other_user)
    FriendRequest.exists?(
      sender_id:   other_user.id,
      receiver_id: self.id,
      accepted:    false
    )
  end

  # User information
  has_one :user_information, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :user_information
  delegate :first_name,
           :last_name,
           :date_of_birth,
           :hometown,
           :about_me, to: :user_information, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  # Posts
  has_many :posts, foreign_key: :author_id, dependent: :destroy

  # Notifications
  has_many :notifications, as: :recipient, dependent: :destroy

  # Likes
  has_many :likes

  # Comments
  has_many :comments, foreign_key: :author_id, dependent: :nullify
end
