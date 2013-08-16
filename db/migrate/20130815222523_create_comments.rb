class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :parent_comment_id
      t.integer :link_id

      t.timestamps
    end
  end
end
