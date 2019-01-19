require 'open-uri'
require 'pry'
require 'nokogiri'

class MiamiVenues::Scraper
  # attr_accessor :events, :arsht_events
  # @events = []

  def arsht_events
   
    events = Nokogiri::HTML(open("http://www.arshtcenter.org/Tickets/Buy-Tickets-Now/"))

    
    puts events.css("div.performanceList")
    

  end



end
