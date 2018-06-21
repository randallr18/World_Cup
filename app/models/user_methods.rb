#HELPER METHODS------------------------

def welcome
  puts "Welcome to Fifa World Cup 2018!"
end

def prompt_user
  puts "We provide real-time, accurate information for passionate fans!"
  puts "Would you like to know information regarding a Team or Stadium?"
  puts "Enter help for more guidance."
end


# COME BACK TO!!!


def get_user_input
  hello = gets.chomp
end

def invalid_command
  puts "Please enter a valid command."
  prompt_user
end


#COMMAND METHODS---------------------------
#help command : output instructions on methods they can use
#exit command : The program should say goodbye and shut down

def helper
  help = <<-HELP
  I accept the following commands:
  - help : displays this help message
  - team : displays a list of all teams you can search
  - stadium : displays a list of all stadiums you can search
  - exit : exits this program

  Please enter one of the above!

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


def team_attribute_finder(name)
  team_object = Team.find_by(country: name)

  total_goals = team_object.team_goals
  goals_against = team_object.team_goals_scored_on
  point_diff = team_object.team_point_differential
  record = team_object.team_record
  opponents = team_object.team_opponents
  stadiums = team_object.team_stadiums
  group = team_object.team_group

  options = <<-OPTIONS
  Aggregated Statistics for #{name}

  - goals : #{total_goals}!
  - goals scored on : #{goals_against}
  - point differential : #{point_diff}
  - record : #{record}
  - opponents : #{opponents}
  - stadiums : #{stadiums}
  - group : #{group}
  OPTIONS

  puts options

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

  Please enter one of the above!

 OPTIONS

   puts options
  end


#RUNNER METHOD-------------------------------

def runner
  welcome
  prompt_user

  loop do
  answer = get_user_input
  case answer
  when 'help'
    helper
    # answer = get_user_input
  when 'team'
    name = get_team
    team_attribute_finder(name)
  when 'stadium'
    get_stadium
    stadium_search
    stadium_attribute_finder
  when 'exit'
    exit_program
    break
  else
    invalid_command
  end
  prompt_user
end
end




#team search: can return all matches, stadiums, total goals, total wins, total losses, goals scored on, point differential, players, opponents, group letter
#stadium search: can return all matches and teams which played there.  plus stadium name & city
#player search: can return ...
#can we look up matches?  if so, the home team, away team, stadium, score
