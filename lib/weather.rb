require_relative "../environment.rb"


class Weather
  @@all = []

  def initialize(attributes)
    attributes.each do |key, value| 
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    end
    celsius_to_fahrenheit
    save 
  end

  def self.weather_exists?(city) 
    @@all.any? {|weather| weather.city.downcase == city.downcase} || @@all.any? {|weather| weather.city.downcase.include?(city.downcase)}
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

end  