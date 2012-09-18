class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :category
      t.string :title
      t.string :content
      t.references :user

      t.timestamps
    end
    add_index :posts, :category_id
    add_index :posts, :user_id
  end
end
