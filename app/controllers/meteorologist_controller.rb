require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{sanitized_street_address}&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78" 
    raw_data = open(url).read
    first_parsed_data = JSON.parse(raw_data)
    f = first_parsed_data.fetch("results").at(0)
    
    @latitude = f.fetch("geometry").fetch("location").fetch("lat")

    @longitude = f.fetch("geometry").fetch("location").fetch("lng")

    url = "https://api.darksky.net/forecast/fc8d58c45ba575874932af8a55aa1674/#{@latitude},#{@longitude}"
    parsed_data = JSON.parse(open(url).read)
   
    @current_temperature =  parsed_data.dig("currently", "temperature")
    
    @current_summary = parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_data.dig("daily", "summary")


    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
