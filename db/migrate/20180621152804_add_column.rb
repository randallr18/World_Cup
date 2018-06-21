class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :home_or_away, :string
  end
end
