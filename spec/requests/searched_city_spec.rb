# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SearchedCities', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      #   let!(:my_sub) { FactoryBot.create(:subscriber) }

      before do
        @searched_city = { 'country' => 'Any', 'city' => 'Any', 'region' => 'Any', 'latitude' => 45, 'longitude' => 45,
                           'weather_description' => 'any', 'icon' => 'any', 'temp' => 20 }
        post '/searched_cities', params:
                          { 'searched_city' => {
                            'country' => @searched_city['country'],
                            'city' => @searched_city['city'],
                            'region' => @searched_city['region'],
                            'latitude' => @searched_city['latitude'],
                            'longitude' => @searched_city['longitude'],
                            'weather_description' => @searched_city['weather_description'],
                            'icon' => @searched_city['icon'],
                            'temp' => @searched_city['temp']
                          } }
        @searched_cities = SearchedCity.order('created_at DESC').limit(10).where.not(id: SearchedCity.last.id)
      end

      it 'returns searched_cities' do
        expect(JSON.parse(response.body).size).to eq(@searched_cities.size)
        expect(JSON.parse(response.body).first['id']).not_to eq(SearchedCity.last.id)
      end

      it 'returns a ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/searched_cities', params:
        { 'searched_city' => {
          'country' => '',
          'city' => '',
          'region' => '',
          'latitude' => '',
          'longitude' => '',
          'weather_description' => '',
          'icon' => '',
          'temp' => ''
        } }
      end

      it 'returns nil' do
        expect(JSON.parse(response.body)).to eq(nil)
      end
    end
  end
  describe 'GET /index' do
    before do
      @searched_cities = SearchedCity.order('created_at DESC').limit(10)
      get '/searched_cities'
    end
    it 'returns 10 cities' do
      expect(JSON.parse(response.body).size).to eq(@searched_cities.size)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /index with params' do
    context 'with vaild city' do
      before do
        @searched_cities = SearchedCity.order('created_at DESC').limit(10)
        get '/searched_cities?search=beirut'
      end
      it 'returns weather details' do
        expect(JSON.parse(response.body)).to have_key('data')
        expect(JSON.parse(response.body)).to have_key('weather')
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'with invalid city' do
      before do
        @searched_cities = SearchedCity.order('created_at DESC').limit(10)
        get '/searched_cities?search=zzzzzzzzzz'
      end
      it 'returns message' do
        expect(JSON.parse(response.body)).to have_key('message')
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
