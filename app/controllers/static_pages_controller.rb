# frozen_string_literal: true

require 'net/http'
class StaticPagesController < ApplicationController
  def user_location_weather
    access_token = ENV['ipinfo_access_token']
    handler = IPinfo.create(access_token)
    ip_address = '185.97.93.7'
    @details = handler.details(ip_address)

    @weather_info = JSON.parse(get_weather(@details.latitude, @details.longitude))

    render json: { 'details' => @details, 'weather_info' => @weather_info }
  end
end
