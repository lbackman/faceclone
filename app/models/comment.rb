class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true, optional: true, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true

  after_create_commit {
    broadcast_append_to [commentable, :comments],
      target: "#{dom_id(commentable, :comments)}",
      partial: "comments/comment",
      locals: { comment: self, commentable: }
  }
end
