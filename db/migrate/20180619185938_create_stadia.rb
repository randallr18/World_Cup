class CreateStadia < ActiveRecord::Migration[5.2]
  def change
    create_table :stadia do |t|
      t.integer :stadium_id
      t.string :name
      t.string :city
  end
  end
end
