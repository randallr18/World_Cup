#!usr/bin/env ruby


require_relative '../config/environment'
require_relative '../app/models/stadium.rb'
require_relative '../app/models/team.rb'
require_relative '../app/models/match.rb'
require_relative '../app/models/user_methods.rb'


Stadium.add_stadiums_from_API
Team.add_teams_from_API
Match.add_hometeam_matches_from_API
Match.add_awayteam_matches_from_API

runner

Stadium.delete_all
Team.delete_all
Match.delete_all
