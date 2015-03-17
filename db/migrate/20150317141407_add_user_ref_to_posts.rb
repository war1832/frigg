class AddUserRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :user_id, index: true
    add_foreign_key :posts, :user_ids
  end
end
