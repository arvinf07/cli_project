require 'pry'
require_relative "../environment.rb"
require_relative "./weather.rb"

class Api
  
  attr_accessor :query, :city_id, :weather


  def initialize(query)
    @query = query
    get_city_id
    fetch_weather
    create_weather
  end  

  def get_city_id
    url = "https://www.metaweather.com/api/location/search/?query=#{self.query}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    city = JSON.parse(response)
    @city_title = city[0]["title"]
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
    day = weather.first
    weather_attr = {state: day["weather_state_name"],
    city: @city_title,
    current_temp: day["the_temp"],
    min_temp: day["min_temp"],
    max_temp: day['max_temp'],
    wind: day['wind_speed'],
    date: day["applicable_date"]
    }
    Weather.new(weather_attr)
  end  

end  

api = Api.new('new york')
Api.new('new york')
Api.new('new york')
Api.new('new york')
Api.new('new york')
Api.new('new york')
Api.new('new york')
Api.new('new york')
binding.pry
'let us pry'