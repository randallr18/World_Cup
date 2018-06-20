class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :stadia, :arena_id
  end
end
