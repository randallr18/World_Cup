#HELPER METHODS------------------------

def welcome
  puts <<-TITLE

███████╗██╗███████╗ █████╗     ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗      ██████╗██╗   ██╗██████╗
██╔════╝██║██╔════╝██╔══██╗    ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗    ██╔════╝██║   ██║██╔══██╗
█████╗  ██║█████╗  ███████║    ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║    ██║     ██║   ██║██████╔╝
██╔══╝  ██║██╔══╝  ██╔══██║    ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║    ██║     ██║   ██║██╔═══╝
██║     ██║██║     ██║  ██║    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝    ╚██████╗╚██████╔╝██║
╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝


  TITLE
  puts "Welcome to Fifa World Cup 2018!"
  puts "We provide real-time, accurate information for passionate fans!"
end

def prompt_user_02
  prompt = TTY::Prompt.new
  answer = prompt.select("Would you like to know information regarding a Team, a Stadium or the Tournament?", %w(Team Stadium Tournament Exit))
  answer.downcase
end


def exit_program
  puts
  puts "Thank you for visiting! Goodbye!"
  puts
end


#TEAM---------------------------------------

def get_team
    puts
    puts "Which team are you interested in?"
    name = gets.chomp
end


def decision_02
  prompt = TTY::Prompt.new
  decis1 = prompt.select("Would you like Match Specific or Aggregated information?") do |menu|
    menu.choice 'Match Specific'
    menu.choice 'Aggregated'
  end
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
    elsif element.win == false
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

def tournament_info_02
  prompt = TTY::Prompt.new
  decis1 = prompt.select("Please select one from the following!") do |menu|
    menu.choice 'Most Goals Scored'
    menu.choice 'Least Goals Scored'
    menu.choice 'Least Goals Scored Against'
    menu.choice 'Most Goals Scored Against'
    menu.choice 'Highest Point Differential'
    menu.choice 'Lowest Point Differential'
  end
end

#STADIUM------------------------------------

def get_stadium_2
  prompt = TTY::Prompt.new
  prompt.select("Which stadium are you interested in?") do |menu|
    Stadium.all.map do |element|
    menu.choice(element.name)
  end
  end
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

    loop do
      answer = prompt_user_02
      case answer
      when 'team'
        loop do
          @name = get_team
          team_object = Team.find_by(country: @name)
          if Team.all.index(team_object) == nil
            puts
            puts "Make sure to capitalize!"
            puts "Please try again!"
          else
            break
          end
        end
      decis = decision_02
      if decis == 'aggregated'
        team_attribute_finder(@name)
      elsif decis == 'match specific'
        match_information(@name)
      end
    when 'stadium'
      name = get_stadium_2
      stadium_information(name)
    when 'tournament'
      info = tournament_info_02
      if info == 'Most Goals Scored'
        puts
        puts Team.team_with_most_goals
        puts
      elsif info == 'Least Goals Scored'
        puts
        puts Team.team_with_least_goals
        puts
      elsif info == 'Most Goals Scored Against'
        puts
        puts Team.team_with_most_goals_scored_on
        puts
      elsif info == 'Least Goals Scored Against'
        puts
        puts Team.team_with_least_goals_scored_on
        puts
      elsif info == 'Highest Point Differential'
        puts
        puts Team.team_with_highest_point_differential
        puts
      elsif info == 'Lowest Point Differential'
        puts
        puts Team.team_with_lowest_point_differential
        puts
      end
      when 'exit'
        exit_program
        break
      else
        invalid_command
      end
    end
end
