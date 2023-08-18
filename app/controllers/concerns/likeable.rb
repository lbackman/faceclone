module Likeable
  extend ActiveSupport::Concern

  def index
    @type = @likeable.class.to_s
    @likes = Like
              .where(likeable: @likeable)
              .includes(user: [:user_information, avatar_attachment: :blob])
    render "likes/index"
  end

  def update
    if @likeable.liked_by?(Current.user)
      @likeable.unlike(Current.user)
    else
      @likeable.like(Current.user)
    end

    render partial: 'likes/likes', locals: { likeable: @likeable, liker: Current.user }
  end
end
