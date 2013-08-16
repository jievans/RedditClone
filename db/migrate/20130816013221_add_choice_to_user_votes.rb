class AddChoiceToUserVotes < ActiveRecord::Migration
  def change
    add_column :user_votes, :choice, :string
  end
end
