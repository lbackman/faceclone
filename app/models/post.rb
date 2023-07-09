class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :body, presence: true

  scope :with_author_information, -> do
    includes(comments: [author: [:user_information]], author: [:user_information])
  end

  scope :of_friends_and_user, ->(user) do
    where("author_id IN (?) OR author_id = ?", User.friends(user).pluck(:id), user.id)
  end
end
