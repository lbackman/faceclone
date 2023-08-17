class Posts::LikesController < ApplicationController
  before_action :set_post

  def update
    if @post.liked_by?(Current.user)
      @post.unlike(Current.user)
    else
      @post.like(Current.user)
    end

    render partial: 'likes/likes', locals: { likeable: @post, liker: Current.user, parent: nil }
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end
end
