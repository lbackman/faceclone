class DisallowNullOnCounterColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :likes_count, :integer, default: 0, null: false
    change_column :posts, :comments_count, :integer, default: 0, null: false

    change_column :comments, :likes_count, :integer, default: 0, null: false
  end
end
