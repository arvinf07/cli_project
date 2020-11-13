require_relative "../environment.rb"


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
    response = Net::HTTP.get(uri) #returns stringIO
    city = JSON.parse(response) #Turns it into ruby hash
    if !city.any? || city[0]["title"].downcase != self.query.downcase
      Cli.invalid_city 
    else
      @city_title = city[0]["title"] #any other way to me to pass these       |  RETURN THEM AS ARRAY, AND PASS THE FUNCTION AS AN
      @city_id = city[0]["woeid"]     #2 variables without an instnace vars?  |   ARGUMENT TO #create_weather  ??  
    end  
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
    wind: day['wind_speed'].to_i,
    date: day["applicable_date"]
    }
    Weather.new(weather_attr)
  end  

end  


