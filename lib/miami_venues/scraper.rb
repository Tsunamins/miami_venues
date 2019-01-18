require 'open-uri'
require 'pry'
require 'nokogiri'

class MiamiVenues::Scraper
  attr_accessor :@events

  @events = []

  def arsht_events
    events = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    puts events.css("ul#eventlist")
  end



end
