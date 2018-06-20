class ChangeColumnName2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :stadia, :stadium_id, :arena_id
  end
end
