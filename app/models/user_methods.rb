#HELPER METHODS------------------------

def welcome
  puts "Welcome to Fifa World Cup 2018!"
  puts "We provide real-time, accurate information for passionate fans!"
end

def prompt_user
  puts "Would you like to know information regarding a Team, a Stadium or the Tournament?"
  puts "Enter help for more guidance."
end

def get_user_input
  hello_1 = gets.chomp
  hello = hello_1.downcase
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
    puts
    puts "Which team are you interested in?"
    name = gets.chomp
end

def decision
  puts
  puts "Would you like Match Specific or Aggregated information?"
  decis1 = gets.chomp
  decis = decis1.downcase
end


def match_information(name)
  team_object = Team.find_by(country: name)
  array = team_object.matches
  counter = 1
  puts
  array.map do |element|
    puts "Match #{counter}"
    if element.win == true
      puts "Result : WIN"
    else
      puts "Result : LOSS"
    end
    puts "Opponent : #{element.opponent}"
    puts "Score : #{element.score}"
    stadium = Stadium.find_by(:id => element.stadium_id)
    puts "Stadium : #{stadium.name}"
    puts
    counter += 1
  end
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

#TOURNAMENT---------------------------------

def tournament_info
  most_goals = Team.team_with_most_goals
  least_goals = Team.team_with_least_goals
  most_against = Team.team_with_most_goals_scored_on
  least_against = Team.team_with_least_goals_scored_on
  highest_diff = Team.team_with_highest_point_differential
  lowest_diff = Team.team_with_lowest_point_differential

  options = <<-HELLO

  - most goals scored : #{most_goals}
  - least goals scored against : #{least_against}
  - highest point differential : #{highest_diff}

  - least goals scored : #{least_goals}
  - most goals scored against : #{most_against}
  - lowest point differential : #{lowest_diff}

  HELLO

  puts options

end

#STADIUM------------------------------------

def get_stadium
  puts "Which stadium are you interested in?"
  name = gets.chomp
end

def stadium_information(name)
  stadium_object = Stadium.find_by(name: name)
  puts
  puts "City : #{stadium_object.city}"
  puts
  puts "Bellow is list of all the matches playes at this stadium!"
  array = stadium_object.matches
  array2 = array.select do |element|
    element.home_or_away == "home"
  end
  counter = 1
  puts
  array2.map do |element|
    puts "Match #{counter}"
    team_object = Team.find_by(id: element.team_id)
    team = team_object.country
    puts "#{team} VS #{element.opponent}"
    puts "Score : #{element.score}"
    puts
    counter += 1
  end
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
    decis = decision
    if decis == 'aggregated'
      team_attribute_finder(name)
    elsif decis == 'match specific'
      match_information(name)
    end
  when 'stadium'
    name = get_stadium
    stadium_information(name)
  when 'tournament'
    tournament_info
  when 'exit'
    exit_program
    break
  else
    invalid_command
  end
  prompt_user
end
end
