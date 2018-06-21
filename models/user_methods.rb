#HELPER METHODS------------------------

def welcome
  puts "Welcome to Fifa World Cup 2018!"
end

def prompt_user
  puts "We provide real-time, accurate information for passionate fans!"
  puts "Would you like to know information reagarding a Team, Player or Stadium?"
  puts "Enter help for more guidance."
end

def get_user_input
  gets.downcase.chomp
end

def invalid_command
  puts "Please enter a valid command."
  prompt_user
end


#COMMAND METHODS---------------------------
#help command : output instructions on methods they can use
#exit command : The program should say goodbye and shut down

def help
  help = <<-HELP
  I accept the following commands:
  - help : displays this help message
  - team : displays a list of all teams you can search
  - stadium : displays a list of all stadiums you can search
  - exit : exits this program
  HELP

  puts help
end


def exit_program
  puts "Thank you for visiting! Goodbye!"
end


#TEAM---------------------------------------

def get_team
    puts "Which team are you interested in?"
    name = gets.chomp
end

def team_search
  options = <<-OPTIONS
  Here is what you can search for:
  - goals : displays total goals for your team
  - goals scored on : displays total goals for your team
  - point differential : displays the current point differential for your team
  - stadiums : displays a list of all stadiums your team has played at
  - wins : displays the total number of wins for your team
  - losses : displays the total number of losses for your team
  - matches : displays all the matches your team has played
  - opponents : displays all the opponents your team has played
  - exit : exits this program
  OPTIONS

  puts options
end

def team_attribute_finder(name)
  team_object = Team.find_by(country: name)

  attribute = gets.downcase.chomp
  case attribute
  when 'goals'
    #name.team_goals
  when 'goals scored on'
    #name.team_goals_scored_on
  when 'point differential'
    #name.team_point_differential
  when 'stadiums'
    #name.team_stadiums
  when 'wins'
    #name.team_wins
  when 'losses'
    #name.team_losses
  when 'matches'
    #name.team_matches
  when 'opponents'
    #name.team_opponents
  when 'exit'
    exit_program
  else
    invalid_command
  end
end

#STADIUM------------------------------------

def get_stadium
  puts "Which stadium are you interested in?"
  name = gets.chomp
end

def stadium_search
   options = <<-OPTIONS
  Here is what you can search for:
  - matches : displays all the matches at your stadium
  - teams : displays all the teams who played at your stadium
  - exit : exits this program
 OPTIONS

   puts options
  end


#RUNNER METHOD-------------------------------

def runner
  welcome
  prompt_user
  answer = get_user_input
  case answer
  when 'help'
    help
  when 'team'
    name = get_team
    team_search
    team_attribute_finder(name)
  when 'stadium'
    get_stadium
    stadium_search
    stadium_attribute_finder
  when 'player'
    get_player
    player_search
    player_attribute_finder
  when 'exit'
    exit_program
    break
  else
    invalid_command
  end
end


#team search: can return all matches, stadiums, total goals, total wins, total losses, goals scored on, point differential, players, opponents, group letter
#stadium search: can return all matches and teams which played there.  plus stadium name & city
#player search: can return ...
#can we look up matches?  if so, the home team, away team, stadium, score
