require 'open-uri'
require 'pry'
require 'nokogiri'
require 'date'




class MiamiVenues::Scraper

def self.perez_art_list
  perez_events = []
  event_hash = {}
  perez_a = Nokogiri::HTML(open("https://www.pamm.org/calendar"))

  #find title of event, dates and url
  perez_a.css("li div.inner").each do |find_detail|

    indiv_date = find_detail.css("span.meta").text

    event_hash = {:event_name => find_detail.css("h4").text,
      :date => self.change_date_format(indiv_date),
      :url => find_detail.css("a").attribute("href").value}

      perez_events << event_hash
  end
  i = 0
  #standardize web url
  while i < perez_events.length
    perez_events[i][:url].prepend("https://www.pamm.org")
    i += 1
  end
  return perez_events
end






  def self.sci_museum_laser_fridays
      laser_fridays = Nokogiri::HTML(open("https://www.frostscience.org/exhibition/planetarium/laser-fridays/"))
      event_hash = {:event_name => "", :date => "", :url => ""}
      laser_date = ""
      arrayed_dates = []
      stored_hashes = []
      laser_events = []
      #find date
      laser_fridays.css("div.centering-container p.subtitle1").each do |find_date|
        laser_date = find_date.text
        arrayed_dates << self.change_date_format(laser_date)
      end
      #find event name and url
      laser_fridays.css("div.centering-container h2").each do |find_detail|
          event_hash = {:event_name => "Laser Fridays",
            :url => find_detail.css("a").attribute("href").value}
          stored_hashes << event_hash
      end
      #put date with event name and url together
      i = 0
      while i < arrayed_dates.length
        stored_hashes[i][:date] = arrayed_dates[i]
        i += 1
      end
      #flatten the laser since it had one too many arrays
      laser_events << stored_hashes
      flat_laser = laser_events.flatten
      return flat_laser

    end

    def self.scrape_the_details(event_url)
      event_details = Nokogiri::HTML(open(event_url))
      details_hash = {}
      if event_url.include?('frost')
        description = event_details.css("p.body_text2").text
        details_hash[:description] = description[0..717]
        details_hash[:time] = event_details.css("span.body_text2").collect do |each_theme|
          each_theme.text
        end
      elsif event_url.include?('calendar') == true
        details_hash[:description] = event_details.css("div.inner p").text
        time_display = event_details.css("span.date-display-single").text
          if time_display == ""
            details_hash[:time] = "Regular museum hours"

          else
            details_hash[:time] = time_display
      end
      elsif event_url.include?('calendar') == false
        description = event_details.css("div.field-item.even p").text
        details_hash[:description] = description[0..1500]

        details_hash[:time] = "Regular museum hours"

      end
      return details_hash
    end

    #helper method to change date format to a standard format
    def self.change_date_format(date_range)
      date_array = []
      if date_range.include?(' - ') || date_range.include?('.')
        arrayed_date = date_range.split(/\W[^ ,A-Z,1-9]/)
        first_day = arrayed_date[0].strip!
        last_day = arrayed_date[1].strip!
        first_day_format = DateTime.parse("#{first_day}")
        last_day_format = DateTime.parse("#{last_day}")
        all_dates = first_day_format..last_day_format
        all_dates.to_a
        all_dates.each do |change_format|
          date_array << change_format.strftime('%a %d %b %Y')
        end
          return date_array
        elsif date_range.include?(" at ")
          date_only = date_range.chomp(' at 7:00 PM')
          date_format = DateTime.parse("#{date_only}")
          match_date_format = date_format.strftime('%a %d %b %Y')
          return match_date_format
        elsif
          date_range.include?("-") == false
          date_format = Date.parse("#{date_range}")
          match_date_format = date_format.strftime('%a %d %b %Y')
          return match_date_format
        end
      end


end
