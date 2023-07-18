module LikesHelper
  def likes_index_path(likeable:, parent:)
    if parent
      comment_likes_path(parent, likeable)
    else
      post_likes_path(likeable)
    end
  end
end
