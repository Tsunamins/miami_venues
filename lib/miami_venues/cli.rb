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
      #some method from eventmatch.rb to match
    elsif user_choice == "2"
      puts "Here are events of that day: "
    else
      puts "That is not an option, try again."
      start
    end






    #example of calling scraper method within here:
    #MiamiVenues::Scraper.scrape
  end




  def format_user_input(user_input)
    user_string = user_input.to_s
    return user_string
  end
end
