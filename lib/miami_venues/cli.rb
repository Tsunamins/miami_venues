#file uner miami_venues as cli.rb
#is a means of namespacing so cli under any other user is specific
#to this gem and not some other user's gem and environment setup

require 'open-uri'
require 'pry'
require 'nokogiri'
require 'date'

class MiamiVenues::CLI
  attr_accessor :event_match, :current_art, :current_laser

  def find_current_events
    @current_laser = MiamiVenues::Scraper.sci_museum_laser_fridays
    MiamiVenues::Events.from_scraped_page(current_laser)
    @current_art = MiamiVenues::Scraper.perez_art_list
    MiamiVenues::Events.from_scraped_page(current_art)
  end

  def start
    find_current_events
    puts "Hello"
    puts "Do you want to find something to do in Miami today or another day?"
    puts "Enter 1 for today, enter 2 for another day: "
    user_input = gets.strip
    user_choice = format_user_input(user_input)

    if user_choice == 0
      todays_events
    elsif user_choice == 1
      alternate_date
    else
      puts "That is not an option, try again."
      start
    end
  end

  def match_up(chosen_date)
    counter = 0
    @event_match = []
    MiamiVenues::Events.all.each_with_index do |search_events|

    search_events.date
      if search_events.date.is_a?(Array)
          series_of_dates = search_events.date
          series_of_dates.each do |find_in_array|
            if find_in_array == chosen_date
              counter += 1
              puts "#{counter}) #{search_events.event}, #{find_in_array}"
              solo_url = search_events.url
              @event_match << solo_url
            end
          end
      elsif search_events.date == chosen_date
          counter += 1
          puts "#{counter}) #{search_events.event}, #{search_events.date}"
          solo_url = search_events.url
          @event_match << solo_url
          end
      end
        @event_match
    end

    def chosen_event(user_event_choice, match_url)
      url = match_url[user_event_choice]
      detailed_view = MiamiVenues::Scraper.scrape_the_details(url)
      description = detailed_view[:description]
      times = detailed_view[:time]
      puts "Time event is occuring: #{times}"
      puts "Description of the event: #{description}"
    end

    #helper method to change date
    def change_user_date(input_date)
      parsed_date = DateTime.parse("#{input_date}")
      use_date = parsed_date.strftime('%a %d %b %Y')
      use_date
    end

    #helper method to change user input as needed
    def format_user_input(user_input)
      modified_input = user_input.to_i - 1
      modified_input
    end


    def choose_another
      puts "Would you like to find another event?"
      puts "1 for yes or 2 for no"
      input = gets.strip
      changed_input = format_user_input(input)
        if changed_input == 0
          puts "Do you want to look at today's events, or an alternate day?"
          puts "Enter 1 for today or 2 for an alternate day."
          next_input = gets.strip
          next_choice = format_user_input(next_input)
            if next_choice == 0
              todays_events
              choose_another
            elsif next_choice == 1
              alternate_date
              choose_another
            end

          elsif changed_input == 1
            exit
          else
            puts "That is an invalid choice, try again"
            choose_another
          end
      end

      def todays_events
          today = Time.new
          todays_date = today.strftime('%a %d %b %Y')
          puts "Here are today's events: "
          match_up(todays_date)
          more_info
      end

      def alternate_date
          puts "Enter your date"
          puts "use a format such as: 2/15/2019, feb 15 2019, february 15, 2019"
          user_date = gets.strip
          chosen_date = change_user_date(user_date)
          puts "Here are events of that day: "
          match_up(chosen_date)
          more_info
      end

      def more_info
          puts "Which event would you like more information about?"

          user_event_input = gets.strip
          user_event_choice = format_user_input(user_event_input)
            if user_event_choice >= 0 && user_event_choice <= @event_match.length
              chosen_event(user_event_choice, @event_match)
              choose_another
            else
              puts "That is not a valid entry, try again."
              more_info
            end
        end
end
