require 'open-uri'
require 'pry'
require 'nokogiri'

class MiamiVenues::Scraper
  # attr_accessor :events
  events = []


def perez_art_list
  perez_a = Nokogiri::HTML(open("https://www.pamm.org/calendar"))

  #find title of event, dates and url

  perez_a.css("li div.inner").each do |find_detail|
    events = {:event_name => find_detail.css("h4").text,
      :date => [find_detail.css("span.meta").text],
      :url => find_detail.css("a").attribute("href").value}
  end
end

puts events

def standard_date
  find_date = events[:date]
  find_date.each do |date|
    if date.include?("-")
      date.split("-")
      first_day = date[0]
      last_day = date[1]
      date_range = first_day..last_day
      date_range.to_a
      date_range.each do |change_format|
        change_format.strftime('%a %d %b %Y')
      end
    elsif date.include?("-") == false
      date.strftime('%a %d %b %Y')
    end
    end
  end










end
