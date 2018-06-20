class Team < ActiveRecord::Base
  has_many :matches
  has_many :stadia, through: :matches

  def self.create_array_from_API
    all_teams = RestClient.get('http://worldcup.sfg.io/teams')
    team_array = JSON.parse(all_teams)
  end

  def self.add_teams_from_API
    self.create_array_from_API.each do |team|
      fifa_num = team["id"]
      team.delete("id")
      team['fifa_id'] = fifa_num
      team.delete("alternate_name")
      self.create(team)
    end
  end
end

# class CreateTeams < ActiveRecord::Migration[5.2]
#   def change
#     create_table :teams do |t|
#       t.string :country
#       t.integer :fifa_id
#       t.string :fifa_code
#       t.integer :group_id
#       t.string :group_letter
#     end
#   end
# end
