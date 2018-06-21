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

  #INSTANCE METHODS------------------------------
  def team_goals
    total_goals = 0
    matches_array = Match.where(team_id: self.id)
    matches_array.map do |match|
      array = match.score.split(" - ")
      if match.home_or_away == "home"
        total_goals += array[0].to_i
      else
        total_goals += array[1].to_i
      end
    end
    total_goals
  end

  def team_goals_scored_on
    total_goals_scored_on = 0
    matches_array = Match.where(team_id: self.id)
    matches_array.map do |match|
      array = match.score.split(" - ")
      if match.home_or_away == "away"
        total_goals_scored_on += array[0].to_i
      else
        total_goals_scored_on += array[1].to_i
      end
    end
    total_goals_scored_on
  end

  def team_point_differential
    goals = team_goals
    goals_scored_on = team_goals_scored_on
    point_differential = goals - goals_scored_on
  end


  def team_wins
    matches_array = Match.where(team_id: self.id)
    matches_array.select do |match|
      match.win == true
    end
    matches_array.length
  end

  def team_losses
    matches_array = Match.where(team_id: self.id)
    matches_array.select do |match|
      match.win == false
    end
    matches_array.length
  end

  def team_record
    wins = team_wins
    losses = team_losses
    record = wins.to_s + ' - ' + losses.to_s
  end


  def team_opponents
    matches_array = Match.where(team_id: self.id)
    array = matches_array.map do |match|
      match.opponent
    end
    array.join(', ')
  end


  def team_stadiums
    matches_array = Match.where(team_id: self.id)
    array = matches_array.map do |match|
      match.stadium.name
    end
    array.join(', ')
  end

  def team_group
    self.group_letter
  end


end


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


  # def home_or_away
  #   self
  #
  # def team_goals
  #   total_goals = 0
  #
  #   team_goals_helper.map do |score|
  #     array = score.split(" - ")
  #     if self





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
