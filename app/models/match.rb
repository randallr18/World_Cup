class Match < ActiveRecord::Base
  belongs_to :stadium
  belongs_to :team

  def self.create_array_from_API
    all_matches = RestClient.get("http://worldcup.sfg.io/matches")
    matches_array = JSON.parse(all_matches)
  end

  def self.add_hometeam_matches_from_API
    self.create_array_from_API.each do |match|
      stadium_id_var = self.find_stadium_id(match)
      team_id_var = self.find_hometeam_id(match)
      if team_id_var == "To Be Determined"
        next
      end
      win_var = self.win_hometeam(match)
      if win_var == nil
        next
      end
      score_var = self.score(match)
      opponent_var = self.opponent_hometeam(match)
      home_team_hash = {stadium_id: stadium_id_var, team_id: team_id_var, win: win_var, score: score_var, opponent: opponent_var}
      self.create(home_team_hash)
    end
  end

  def self.find_stadium_id(match)
    location = match["location"]
    stadium_object = Stadium.find_by(:name => location)
    stadium_object.id
  end

  def self.find_hometeam_id(match)
    team = match["home_team"]["country"]
    if team == "To Be Determined"
      team
    else
    team_object = Team.find_by(:country => team)
    team_object.id
  end
  end

  def self.win_hometeam(match)
    winner = match["winner"]
    if winner == nil
      return winner
    else
      if winner == match["home_team"]["country"]
      true
      else false
      end
    end
  end

  def self.score(match)
    score_home = match["home_team"]["goals"].to_s
    score_away = match["away_team"]["goals"].to_s
    "#{score_home} - #{score_away}"
  end

  def self.opponent_hometeam(match)
    match["away_team"]["country"]
  end

  def self.add_awayteam_matches_from_API
    self.create_array_from_API.each do |match|
      stadium_id_var = self.find_stadium_id(match)
      team_id_var = self.find_awayteam_id(match)
      if team_id_var == "To Be Determined"
        next
      end
      win_var = self.win_awayteam(match)
      if win_var == nil
        next
      end
      score_var = self.score(match)
      opponent_var = self.opponent_awayteam(match)
      away_team_hash = {stadium_id: stadium_id_var, team_id: team_id_var, win: win_var, score: score_var, opponent: opponent_var}
      self.create(away_team_hash)
    end
  end

  def self.find_awayteam_id(match)
    team = match["away_team"]["country"]
    if team == "To Be Determined"
      team
    else
    team_object = Team.find_by(:country => team)
    team_object.id
  end
  end

  def self.win_awayteam(match)
    winner = match["winner"]
    if winner == nil
      return winner
    else
      if winner == match["away_team"]["country"]
      true
      else false
      end
    end
  end

  def self.opponent_awayteam(match)
    match["home_team"]["country"]
  end


end
