class CreateWows < ActiveRecord::Migration
  def change
    create_table :wows do |t|

      t.timestamps
    end
  end
end
