# frozen_string_literal: true

class SearchedCitiesController < ApplicationController
  def index
    @searched_cities = SearchedCity.order('created_at DESC').limit(10)
    if params[:search].present?

      @data = get_city(params[:search])
      if @data
        lat = @data['lat']
        long = @data['lon']
        @weather = JSON.parse(get_weather(lat, long))
        if @weather

          # SearchedCity.create(city:@data["address"]["city"],country:@data["address"]["country"],
          #                     region:@data["address"]["country"],latitude:lat,longitude:long,
          #                     weather_description:@weather["weather"][0]["description"],icon:@weather["weather"][0]["icon"],
          #                     temp: @weather["main"]["temp"])
          # @searched_cities = SearchedCity.order("created_at DESC").limit(10).where.not(id:SearchedCity.last.id)
          render json: { 'data' => @data, 'weather' => @weather }
        else
          render json: { 'message' => 'Error getting weathor', 'searched_cities' => @searched_cities }
        end
      else
        render json: { 'message' => 'Invalid City Name', 'searched_cities' => @searched_cities }

      end
    else
      render json: @searched_cities
    end
  end

  def create
    @searched_city = SearchedCity.new(city_params)
    if @searched_city.save
      @searched_cities = SearchedCity.order('created_at DESC').limit(10).where.not(id: SearchedCity.last.id)
      render json: @searched_cities
    else
      render json: nil
    end
  end

  private

  def city_params
    params.require(:searched_city).permit(:city, :country, :region, :latitude, :longitude, :weather_description, :icon,
                                          :temp)
  end
end
