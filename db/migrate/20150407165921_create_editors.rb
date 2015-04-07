class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.references :user, index: true
      t.references :blog, index: true

      t.timestamps null: false
    end
    add_foreign_key :editors, :users
    add_foreign_key :editors, :blogs
  end
end
