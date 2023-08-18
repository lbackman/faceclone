class Posts::LikesController < ApplicationController
  include Likeable
  before_action :set_likeable

  private

    def set_likeable
      @likeable = Post.find(params[:post_id])
    end
end
