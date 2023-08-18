class Posts::LikesController < ApplicationController
  include Likeable
  before_action :set_likeable, :set_parent

  private

    def set_likeable
      @likeable = Post.find(params[:post_id])
    end

    def set_parent
      @parent = nil
    end
end
