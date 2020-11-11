require 'pry'
require_relative "../environment.rb"
require_relative "./weather.rb"

class Api
  
  attr_accessor :query, :city_id, :weather

  def initialize(query)
    @query = query
    get_city_id
    fetch_weather
  end  

  def get_city_id
    url = "https://www.metaweather.com/api/location/search/?query=#{self.query}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    city = JSON.parse(response)
    @city_id = city[0]["woeid"]
  end  

  def fetch_weather
    url = "https://www.metaweather.com/api/location/#{self.city_id}/"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
    @weather = JSON.parse(response)["consolidated_weather"]
  end  

  def create_weather
    weather.each do |day|
      weather_attr = {state: day["weather_state_name"],
      current_temp: day["the_temp"],
      min_temp: day["min_temp"],
      max_temp: day['max_temp'],
      wind: day['wind_speed'],
      date: day["applicable_date"]
      }
      binding.pry
      Weather.new(weather_attr)
    end  
  end  

end  

api = Api.new('new york')
binding.pry
'let us pry'