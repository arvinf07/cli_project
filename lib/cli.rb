require 'pry'
require_relative "../environment.rb"
require_relative "./api.rb"
require_relative "./weather.rb"


class Cli

  def start
    puts "\n\nWelcome to Weather Getter 2020!\n\n"
    display_options
  end

  def display_options 
    Weather.all.each.with_index do |weather, index|
      puts "#{index + 1}. #{weather.city}\n\n"
    end  
    puts "Enter the number for the city's weather you wish to see"
    puts "If the city you are looking for is not on the list\ntype 'new' to search for a new city."
    puts "When you are done type 'exit' to quit the program"
    user_input = gets.chomp
    if user_input.downcase == 'new'
      #create new weather object 
    elsif user_input.downcase == 'exit'
      puts "Bye! Enjoy the weather, or not"  
      exit 
    elsif user_input == 'list'
      display_options  
    elsif user_input.to_i.between?(1, Weather.all.size)
      weather = Weather.all[user_input.to_i-1]
      forecast_display(weather)
    else 
      puts "That is not a valid command. Try again bucko"  
      display_options
    end  
  end  

  def forecast_display(weather)
    if weather.state == "Clear" || weather.state.include?('Cloud')
      puts "Current weather in #{weather.city} is looking good!\n\n"
      puts "The current temperature is #{weather.current_temp}°F, with the a max of #{weather.max_temp}°F and a low of #{weather.min_temp}°F"
      puts "Wind speed of #{weather.wind.to_i}mph " 
      if weather.state == 'Clear' 
        puts "Clear sky with no chance of rain!" 
      else  
        puts "A little cloudy with a slight chance of rain"
      end

    else 
      puts "Current weather in #{weather.city} is not looking so good\n\n"
      puts "The current temperature is #{weather.current_temp}°F, with the a max of #{weather.max_temp}°F and a low of #{weather.min_temp}°F"
      puts "Wind speed of #{weather.wind.to_i}mph " 
      if weather.state == "Showers" || weather.state.include?("Rain")
        puts "Dont forget your umbrella. There is some rain expected"
      elsif weather.state == "Thunderstorm"
        puts "Stay home if you can. There is a Thunderstorm in #{weather.city}"  
      elsif weather.state == "Snow" || weather.state == "Sleet"
        puts "Dont forget your boots. It will be snowing in #{weather.city}"
      else  
        puts "Watch your head! Its hailing in #{weather.city}"
      end  
    end  
    display_options
  end  

end  