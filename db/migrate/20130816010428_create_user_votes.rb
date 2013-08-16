class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id
      t.integer :link_id

      t.timestamps
    end

    add_index :user_votes, [:user_id, :link_id]
  end
end
