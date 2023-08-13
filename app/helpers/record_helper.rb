module RecordHelper
  def friend_buttons_id(id1, id2)
    "friend_buttons_#{[id1, id2].min}_#{[id1, id2].max}"
  end

  def dom_id_for_records(*records, prefix: nil)
    records.map do |record|
      dom_id(record, prefix)
    end.join("_")
  end
end
