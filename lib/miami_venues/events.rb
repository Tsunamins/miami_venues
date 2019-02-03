require 'open-uri'
require 'pry'
require 'nokogiri'
require 'date'

class MiamiVenues::Events
            attr_accessor :event, :url, :date

@@all = []

def initialize(hash)
  @event = hash[:event_name]
  @date = hash[:date]
  @url = hash[:url]
  @@all << self
end

def self.scraped_page(scraped_array)
  scraped_array.each do |new_event|
    @@all << self.new(new_event)
  end
end

def self.all
  @@all
end








end
