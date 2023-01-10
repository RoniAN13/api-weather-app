# frozen_string_literal: true

class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(sub_params)

    if @subscriber.save
      render json: { 'subscriber' => @subscriber, 'flag' => true }

    else
      render json: { 'subscriber' => @subscriber.errors.full_messages.first, 'flag' => false }

    end
  end

  def destroy
    @subscriber = Subscriber&.find(params[:id])

    if @subscriber.destroy
      render json: { "flag": true, "subscriber": @subscriber }
    else
      render json: { "flag": false, "subscriber": @subscriber }
    end
  end

  def unsubscribe
    @subscriber = Subscriber&.find_by(email: params[:email])
    if @subscriber
      render json: { 'subscriber' => @subscriber, 'flag' => true }
    else
      render json: { 'flag' => false }
    end
  end

  def index
    @subscribers = Subscriber.all
    render json: @subscribers
  end

  def show
    @subscriber = Subscriber.find(params[:id])
    resp = Geocoder.search([@subscriber.latitude, @subscriber.longitude])
    @details = resp.first
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV['open_weather_api_key']}"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    @weather_info = JSON.parse(res.body)
    render json: { 'details' => @details, 'weather_info' => @weather_info }
  end

  private

  def sub_params
    params.require(:subscriber).permit(:email, :latitude, :longitude)
  end
end
