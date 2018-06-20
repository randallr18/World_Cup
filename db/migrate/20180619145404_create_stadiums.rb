class CreateStadiums < ActiveRecord::Migration[5.2]
  def change
    create_table :stadiums do |t|
      t.integer :stadium_id
      t.string :name
      t.string :city
    end
  end
end
