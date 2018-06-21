class Stadium < ActiveRecord::Base
  has_many :matches
  has_many :teams, through: :matches

  def self.create_array_from_API
    all_stadiums = RestClient.get('http://worldcup.sfg.io/matches')
    stadiums_array = JSON.parse(all_stadiums)
  end

  def self.add_stadiums_from_API
    self.create_array_from_API.each do |stadium|
      name_var = stadium["location"]
      city_var = stadium["venue"]
      stadium_hash = {name: name_var, city: city_var}
      if self.find_by(name: name_var) == nil
      self.create(stadium_hash)
    end
    end
  end
end

#INSTANCE METHODS------------------------

  def matches(stadium)
  end 

















# class CreateStadiums < ActiveRecord::Migration[5.2]
#   def change
#     create_table :stadiums do |t|
#       t.integer :stadium_id
#       t.string :name
#       t.string :city
#     end
#   end
# end

#
# class Stadium < ActiveRecord::Base
#   has_many :matches
#   has_many :teams, through: :matches
#
#   def self.create_hash_from_API
#     all_stadiums = RestClient.get('https://raw.githubusercontent.com/lsv/fifa-worldcup-2018/master/data.json')
#     stadiums_hash = JSON.parse(all_stadiums)
#   end
#
#   def self.add_stadiums_from_API
#     self.create_hash_from_API["stadiums"].each do |stadium|
#       stadium.delete("lat")
#       stadium.delete("lng")
#       stadium.delete("image")
#       stad_id = stadium["id"]
#       stadium.delete("id")
#       stadium["arena_id"] = stad_id
#       self.create(stadium)
#     end
#   end
# end
#
