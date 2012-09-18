class CreateCommentvotes < ActiveRecord::Migration
  def change
    create_table :commentvotes do |t|
      t.references :user
      t.references :comment

      t.timestamps
    end
    add_index :commentvotes, :user_id
    add_index :commentvotes, :comment_id
  end
end
