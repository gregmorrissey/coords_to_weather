require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @latitude = 37.8267.to_s
    @longitude = -122.423.to_s
    your_api_key = "2bdca4828e0a4365023c66bdb8cbb230"

    # Your code goes here.
    url = "https://api.forecast.io/forecast/" + your_api_key +"/" + @latitude +","+ @longitude
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
