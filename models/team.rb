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


#INSTANCE METHODS-------------------------------------------------------

  def team_goals_helper
    matches_array = Match.where(team_id: self.id)
    binding.pry
    matches_array.map do |match|
      match.score
    end
  end

  def team_goals
    team_goals_helper
  end

end

#
#   def team_goals_scored_on
#   end
#
#   def team_point_differential
#   end
#
#   def team_wins
#   end
#
#   def team_losses
#   end
#
#   def team_matches
#   end
#
#   def team_opponents
#   end
#
#   def team_stadiums
#   end
#
#   def team_group
#   end
#
#
# #CLASS METHODS-------------------------------------------------------
#   def self.team_with_most_goals
#   end
#
#   def self.team_with_least_goals
#   end
#
#   def self.team_with_most_goals_scored_on
#   end
#
#   def self.team_with_least_goals_scored_on
#   end
#
#   def self.team_with_highest_point_differential
#   end
#
#   def self.team_with_lowest_point_differential
#   end
#
#   def self.team_with_most_wins
#   end
#
#   def team_with_most_losses
#   end





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
