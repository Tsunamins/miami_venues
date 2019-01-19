require 'open-uri'
require 'pry'
require 'nokogiri'

class MiamiVenues::Scraper
  attr_accessor :events
  @events = []

  def arsht_events
    #TODO change website here:
    events = Nokogiri::HTML(open("http://www.arshtcenter.org/Tickets/Buy-Tickets-Now/"))


    events.css("ul#eventList")

  end



end
