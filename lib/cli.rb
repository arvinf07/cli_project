require 'pry'
require_relative "../environment.rb"
require_relative "./api.rb"
require_relative "./weather.rb"


class Cli

  def self.start
    puts "\n\nWelcome to Weather Getter 2020!\n\n"
    display_options
  end

  def self.display_options 
    Weather.all.each.with_index do |weather, index|
      puts "#{index + 1}. #{weather.city}\n\n"
    end  
    puts "Enter the number for the city's weather you wish to see"
    puts "If the city you are looking for is not on the list\ntype 'new' to search for a new city."
    puts "When you are done type 'exit' to quit the program"
    puts "------------------------------------------------------------------------------\n\n"
    user_input = gets.strip
    if user_input.downcase == 'new' 
      add_city
    elsif user_input.downcase == 'exit'
      puts "Bye! Enjoy the weather, or not"  
      exit 
    elsif user_input == 'list'
      sleep(3)
      display_options  
    elsif user_input.to_i.between?(1, Weather.all.size)
      forecast_display(Weather.all[user_input.to_i-1])
      sleep(5)
    else 
      puts "\n\nThat is not a valid command. Try again bucko\n\n"  
      sleep(3)
      display_options
    end  
  end  

  def self.forecast_display(weather)
    if weather.state == "Clear" || weather.state.include?('Cloud')
      puts "------------------------------------------------------------------------------"
      puts "\nCurrent weather in #{weather.city} is looking good!\n\n"
      puts "The current temperature is #{weather.current_temp}°F, with the a max of #{weather.max_temp}°F and a low of #{weather.min_temp}°F"
      puts "Wind speed of #{weather.wind.to_i}mph " 
      if weather.state == 'Clear' 
        puts "Clear sky with no chance of rain!" 
      else  
        puts "A little cloudy with a slight chance of rain\n\n"
        puts "------------------------------------------------------------------------------"
      end
    else 
      puts "------------------------------------------------------------------------------"
      puts "\nCurrent weather in #{weather.city} is not looking so good\n\n"
      puts "The current temperature is #{weather.current_temp}°F, with the a max of #{weather.max_temp}°F and a low of #{weather.min_temp}°F"
      puts "Wind speed of #{weather.wind.to_i}mph " 
      if weather.state == "Showers" || weather.state.include?("Rain")
        puts "Dont forget your umbrella. There is some rain expected"
        puts "------------------------------------------------------------------------------"
      elsif weather.state == "Thunderstorm"
        puts "Stay home if you can. There is a Thunderstorm in #{weather.city}" 
        puts "------------------------------------------------------------------------------" 
      elsif weather.state == "Snow" || weather.state == "Sleet"
        puts "Dont forget your boots and be careful driving. It will be snowing in #{weather.city}"
        puts "------------------------------------------------------------------------------"
      else  
        puts "Watch your head! Its hailing in #{weather.city}"
        puts "------------------------------------------------------------------------------"
      end  
    end  
    sleep(3)
    display_options
  end  

  def self.add_city
    puts "What city would you like to add?(only CITIES are valid)"
    new_city = gets.strip.downcase
    if Weather.weather_exists?(new_city)
      puts "\nThat city is already on the list. Look...\n\n"
      sleep(3)
      display_options
    else
      Api.new(new_city)  
      forecast_display(Weather.all.last)
      sleep(5)
      display_options
    end
  end  

  def self.invalid_city
    puts "Sorry the city you entered cannot be found"
    puts "Check your spelling and try adding it again\n\n"
    sleep(3)
    display_options
  end  

end  