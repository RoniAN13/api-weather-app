# frozen_string_literal: true

class ApplicationController < ActionController::API
  def get_city(city)
    data = Geocoder.search(city)
    return unless data.any?

    res = JSON.parse(data.to_json)[0]['data']
  end

  def get_weather(lat, long)
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&units=metric&appid=#{ENV['open_weather_api_key']}"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    return res.body if res.code == '200'

    nil
  end
end
