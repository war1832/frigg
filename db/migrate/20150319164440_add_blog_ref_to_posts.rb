class AddBlogRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :blog, index: true
    add_foreign_key :posts, :blogs
  end
end
