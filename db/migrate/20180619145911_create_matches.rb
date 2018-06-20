class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :stadium_id
      t.integer :team_id
      t.boolean :win
      t.string :score
      t.string :opponent
    end
  end
end
