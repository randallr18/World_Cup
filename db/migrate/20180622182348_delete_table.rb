class DeleteTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :stadiums
  end
end
