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
      format_today = today.strftime('%a %d %b %Y')

      puts format_today

      puts "Here are today's events: "
  
    elsif user_choice == "2"
      puts "Enter your date"
      puts "use a format such as: 2/15/2019, feb 15 2019, february 15, 2019"
      user_date = gets.strip
      change_user_date(user_date)
      puts "Here are events of that day: "
    else
      puts "That is not an option, try again."
      start
    end






    #example of calling scraper method within here:
    #MiamiVenues::Scraper.scrape
  end
  #helper method to change date each time
  def change_user_date(input_date)
    parsed_date = DateTime.parse("#{input_date}")
    use_date = parsed_date.strftime('%a %d %b %Y')
    puts use_date
  end



  #helper method to change user input as needed
  def format_user_input(user_input)
    user_string = user_input.to_s
    return user_string
  end
end
