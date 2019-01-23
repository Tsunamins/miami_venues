require 'open-uri'
require 'pry'
require 'nokogiri'

class MiamiVenues::Scraper
  # attr_accessor :events, :arsht_events
  # @events = []

  def arsht_events
<<<<<<< HEAD
    #TODO change website here:
    events = Nokogiri::HTML(open("http://www.arshtcenter.org/Tickets/Buy-Tickets-Now/"))


    events.css("ul#eventList")
=======
   
    events = Nokogiri::HTML(open("http://www.arshtcenter.org/Tickets/Buy-Tickets-Now/"))

    
    puts events.css("div.performanceList")
    
>>>>>>> 7a7cd1c36df7bf8d1b0a401c64f8bba9caa5b577

  end



end
