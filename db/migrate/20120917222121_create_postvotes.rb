class CreatePostvotes < ActiveRecord::Migration
  def change
    create_table :postvotes do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :postvotes, :user_id
    add_index :postvotes, :post_id
  end
end
