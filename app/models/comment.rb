class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true, optional: true, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
end
