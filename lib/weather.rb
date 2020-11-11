require 'pry'
require_relative "../environment.rb"
require_relative "./api.rb"

class Weather
  @@city = api.city_title
  @@all = []

  def initialize(attributes)
    attributes.each do |key, value| 
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    end
    celsius_to_fahrenheit
    save 
  end

  def self.all
    @@all
  end  

  def save 
    @@all << self
  end

  def celsius_to_fahrenheit
    @current_temp = (@current_temp * 1.8 + (32)).to_i
    @min_temp = (@min_temp * 1.8 + (32)).to_i
    @max_temp = (@max_temp * 1.8 + (32)).to_i
  end  

  def forecast_display
    if @state == "Clear" && @current_temp > 50 && @@all.first == self
      puts "Todays weather is looking good!\n\n"
      puts "The current temperature is #{@current_temp}°F, with the a max of #{@max_temp}°F and a low of #{@min_temp}°F"
      puts "Wind speed of #{@wind.to_i}mph " 
      puts "A Clear sky with 0% chance of rain"
    end  
  end  

  def self.today_forecast
    if 
      puts "Todays weather looks good!"

    end  
  end  

  def self.forecast
    puts "The weather in #{@@city} for the next 5 days:"
    @@all.each do |weather|

    end 
    
  end  
end  