#file uner miami_venues as cli.rb
#is a means of namespacing so cli under any other user is specific
#to this gem and not some other user's gem and environment setup

require 'open-uri'
require 'pry'
require 'nokogiri'
require 'date'

class MiamiVenues::CLI

  #code to see if all is setup correctly
  #called in bin findjobs to initially check
  def start
    puts "Hello"
    puts "Do you want to find something to do in Miami today or another day?"
    puts "Enter 1 for today, enter 2 for another day: "
    user_input = gets.strip
    user_choice = format_user_input(user_input)

    if user_choice == "1"
      today = Time.new
      todays_date = today.strftime('%a %d %b %Y')

      puts "Here are today's events: "
      match_up(todays_date)

    elsif user_choice == "2"
      puts "Enter your date"
      puts "use a format such as: 2/15/2019, feb 15 2019, february 15, 2019"
      user_date = gets.strip
      chosen_date = change_user_date(user_date)

      puts "Here are events of that day: "
      match_up(chosen_date)
    else
      puts "That is not an option, try again."
      start
    end
  end



  def match_up(chosen_date)
    #needs to be present or called at some point
    find_current_events
    counter = 1
    event_match = []
    MiamiVenues::Events.all.each_with_index do |search_events|

      search_events.date
      if search_events.date.is_a?(Array)

        series_of_dates = search_events.date
        series_of_dates.each do |find_in_array|
          if find_in_array == chosen_date
            counter += 1
            puts "#{counter}) #{search_events.event}, #{find_in_array}"
            event_match << self
          end
        end
      elsif search_events.date == chosen_date
        puts "#{counter}) #{search_events.event}, #{search_events.date}"
        event_match << self
      end

      end
      return event_match

  end






  #find and create events based on scraper and event classes
  def find_current_events
    current_laser = MiamiVenues::Scraper.sci_museum_laser_fridays
    MiamiVenues::Events.from_scraped_page(current_laser)
    current_art = MiamiVenues::Scraper.perez_art_list
    MiamiVenues::Events.from_scraped_page(current_art)
  end

  def display_all
    #need this line for the moment the way testconsole is setup
    find_current_events
    puts "All Events:"
    MiamiVenues::Events.all.each_with_index do |list_details, index|
      display_index = index + 1
      puts "#{display_index}) #{list_details.event}"
    end
  end

  #helper method to change date
  def change_user_date(input_date)
    parsed_date = DateTime.parse("#{input_date}")
    use_date = parsed_date.strftime('%a %d %b %Y')
    return use_date
  end

  #helper method to change user input as needed
  def format_user_input(user_input)
    user_string = user_input.to_s
    return user_string
  end
end
