module Likeable
  extend ActiveSupport::Concern
  
  def update
    if @likeable.liked_by?(Current.user)
      @likeable.unlike(Current.user)
    else
      @likeable.like(Current.user)
    end

    render partial: 'likes/likes', locals: { likeable: @likeable, liker: Current.user, parent: @parent }
  end
end
