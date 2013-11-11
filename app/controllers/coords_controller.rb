require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @address =  if params[:address] == ""
                    "Old Range Steakhouse, Tahoe Vista, CA"
                else
                    params[:address]
                end
    @url_safe_address = URI.encode(@address)

    # Your code goes here.
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@url_safe_address+"&sensor=false"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @latitude = (parsed_data["results"][0]["geometry"]["location"]["lat"]).to_s
    @longitude = (parsed_data["results"][0]["geometry"]["location"]["lng"]).to_s

    #@latitude = 42.0538387.to_s
    #@longitude = -87.67721.to_s
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
