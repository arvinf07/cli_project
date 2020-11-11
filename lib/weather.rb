require 'pry'
require_relative "../environment.rb"
require_relative "./api.rb"

class Weather

  @@all = []


  # def initialize(state:, max_temp:, min_temp:, current_temp:, wind:, date:)
  def initialize(attributes)
    attributes.each do |key, value| 
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    end
    save 
  end

  def self.all
    @@all
  end  

  def save 
    @@all << self
  end

  # def celsius_to_fareheight

  # end  

  # def five_day_forecast

  # end  
end  