require 'open-uri'
require 'pry'
require 'nokogiri'
require 'date'

#note where appropriate or where intersted add a default location
#i.e. laser fridays are always at frost planetarium so by default at
#frost planetarium
#some have time some don't, i.e. later fridays usually at 7:00
#laser fridays also provides a small description of that weeks laser show
#so need description category also


class MiamiVenues::Scraper
   attr_accessor :events, :event_hash
  #not sure, but maybe have keys in advance for order, but maybe not necessary
  #events = [{:event_name => "", :date => [], :time => "", :url => "", :description => ""}]
  @@events = []

def perez_art_list
  #@events = []
  event_hash = {}
  perez_a = Nokogiri::HTML(open("https://www.pamm.org/calendar"))

  #find title of event, dates and url

  perez_a.css("li div.inner").each do |find_detail|
    indiv_date = find_detail.css("span.meta").text
    event_hash = {:event_name => find_detail.css("h4").text,
      :date => change_date_format(indiv_date),
      :url => find_detail.css("a").attribute("href").value}

      @@events << event_hash

  end
  #puts events for now, later print/return events in another method after date changed
  puts @@events


end

#first part of if statemtn works but changes ev thing to dates in @@events
#so have to go back through and prob keep dates separate then input this
#modified date finding and formatting method into perez art list above
#so keep this as an example but make a new perez_get_and_process dates or someting method

def change_date_format(date_range)
  date_array = []
  if date_range.include?("-")
    arrayed_date = date_range.split("-")
    first_day = arrayed_date[0]
    last_day = arrayed_date[1]
    first_day.strip!
    last_day.strip!
    first_day_format = DateTime.parse("#{first_day}")
    last_day_format = DateTime.parse("#{last_day}")
    date_range = first_day_format..last_day_format
    date_range.to_a
    date_range.each do |change_format|
      date_array << change_format.strftime('%a %d %b %Y')
    end
      return date_array
    elsif
      date_range.include?("-") == false
      date_format = DateTime.parse("#{date_range}")
      match_date_format = date_format.strftime('%a %d %b %Y')
      return match_date_format
    end
  end

def perez_dates
  i = 0
  date_array = []
  date_string = ""
  while i < @@events.length
    find_date = @@events[i][:date]
    i += 1
    if find_date.include?("-")

      arrayed_date = find_date.split(" - ")

      first_day = arrayed_date[0]
      last_day = arrayed_date[1]
      first_day.strip!
      last_day.strip!

      #binding.pry

      first_day_format = DateTime.parse("#{first_day}")
      last_day_format = DateTime.parse("#{last_day}")
      date_range = first_day_format..last_day_format
      date_range.to_a
      date_range.each do |change_format|
        date_array << change_format.strftime('%a %d %b %Y')

      end
      @@events[i][:date] = date_array
      #binding.pry
    elsif find_date.include?("-") == false
      date_format = Date.parse("#{find_date}")
      match_date_format = date_format.strftime('%a %d %b %Y')
      @@events[i][:date] =  match_date_format

    end


    end

  end

#   def sci_museum_laser_fridays
#       laser_fridays = Nokogiri::HTML(open("https://www.frostscience.org/exhibition/planetarium/laser-fridays/"))
#
#       laser_fridays.css("div.centering-container h2").each do |url|
#         event_hash[:url] = url.css("a").attribute("href").value
#       end
#
#       laser_fridays.css("div.centering-container").each do |dates|
#       event_hash[:date] = dates.css("p.subtitle1").text
#       event_hash[:description] = desc.css("p.body_text4").text
#     end
# end


end

# event_hash = {:event_name => find_detail.css("h4").text,
#   :date => find_detail.css("span.meta").text,
#   :url => find_detail.css("a").attribute("href").value}
