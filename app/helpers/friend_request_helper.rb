module FriendRequestHelper
  def friend_buttons_id(id1, id2)
    "friend_buttons_#{[id1, id2].min}_#{[id1, id2].max}"
  end
end
