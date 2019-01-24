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
  # attr_accessor :events
  #not sure, but maybe have keys in advance for order, but maybe not necessary
  events = [{:event_name => "", :date => [], :time => "", :url => "", :description => ""}]


def perez_art_list
  perez_a = Nokogiri::HTML(open("https://www.pamm.org/calendar"))

  #find title of event, dates and url

  perez_a.css("li div.inner").each do |find_detail|
    events[:event_name] = find_detail.css("h4").text

      events[:url] = find_detail.css("a").attribute("href").value
      incoming_date = find_detail.css("span.meta").text
      events[:date] = perez_dates(incoming_date)

  end

end

def perez_dates(in_date)
  find_date = events[:date]
  find_date.each do |date|
    if date.include?("-")
      date.split("-")
      first_day = date[0]
      last_day = date[1]
      date_range = first_day..last_day
      date_range.to_a
      date_range.each do |change_format|
        return change_format.strftime('%a %d %b %Y')
      end
    elsif date.include?("-") == false
      return date.strftime('%a %d %b %Y')
    end
    end
  end

  def sci_museum_laser_fridays
      laser_fridays = Nokogiri::HTML(open("https://www.frostscience.org/exhibition/planetarium/laser-fridays/"))

      laser_fridays.css("div.centering-container h2").each do |url|
        events[:url] = url.css("a").attribute("href").value
      end

      laser_fridays.css("div.centering-container").each do |dates|
      events[:date] = dates.css("p.subtitle1").text
      events[:description] = desc.css("p.body_text4").text
    end
end


end
