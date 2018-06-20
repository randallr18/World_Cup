require 'nokogiri'
require 'open-uri'
require 'pry'

html = open("https://www.fifa.com/worldcup/players/browser/")

doc = Nokogiri::HTML(html)


second_level = doc.css(".fi-basic-template")
third_level = second_level.css(".fi-boxed-page")
fourth_level = third_level.css(".section")
fifth_level_01 = fourth_level.css(".container-fluid")
fifth_level_02 = fifth_level_01.css(".container-fluid")
sixth_level = fifth_level_02.css(".fi-players__browser-position")
seventh_level = sixth_level.css(".row")
eighth_level = seventh_level.css(".fi-p--hub")


binding.pry
