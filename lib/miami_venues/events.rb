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

  #@@all << self
end

def self.from_scraped_page(scraped_array)

  scraped_array.each do |new_event|
    self.new(new_event).save
  end
end

def self.all

  @@all
end

def save
  self.class.all << self
end








end
