class UniqueFriendRequestValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if FriendRequest.exists?(
      sender_id: [record.sender_id, record.receiver_id],
      receiver_id: [record.sender_id, record.receiver_id]
    )
      record.errors.add(attribute, message: "Duplicate friend request")
    end
  end
end
