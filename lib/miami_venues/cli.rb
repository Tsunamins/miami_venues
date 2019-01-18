#file uner miami_venues as cli.rb
#is a means of namespacing so cli under any other user is specific
#to this gem and not some other user's gem and environment setup


class MiamiVenues::CLI

  #code to see if all is setup correctly
  #called in bin findjobs to initially check
  def start
    puts "Hello"

    #example of calling scraper method within here:
    #MiamiVenues::Scraper.scrape
  end
end
