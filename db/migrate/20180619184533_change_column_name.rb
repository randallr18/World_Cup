class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :stadiums, :stadium_id, :arena_id
  end
end
