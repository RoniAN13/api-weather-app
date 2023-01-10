# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscribers', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      #   let!(:my_sub) { FactoryBot.create(:subscriber) }

      before do
        @sub = { 'email' => 'example@gmail.com', 'latitude' => 45, 'longitude' => 45 }
        post '/subscribers', params:
                          { 'subscriber' => {
                            'email' => @sub['email'],
                            'latitude' => @sub['latitude'],
                            'longitude' => @sub['longitude']

                          } }
      end

      it 'returns the email' do
        # expect(JSON.parse(response.body)["flag"]).to eq(true)
        expect(JSON.parse(response.body)['subscriber']['email']).to eq(@sub['email'])
      end

      it 'returns the latitude' do
        expect(JSON.parse(response.body)['subscriber']['latitude']).to eq(@sub['latitude'])
      end
      it 'returns the longitude' do
        expect(JSON.parse(response.body)['subscriber']['longitude']).to eq(@sub['longitude'])
      end

      it 'returns a ok status' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a true flag' do
        expect(JSON.parse(response.body)['flag']).to eq(true)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/subscribers', params:
                          { 'subscriber' => {
                            'email' => '',
                            'latitude' => '',
                            'longitude' => ''

                          } }
      end

      it 'returns a false flag' do
        expect(JSON.parse(response.body)['flag']).to eq(false)
      end
    end
  end
  describe 'GET /index' do
    before do
      @subscribers = Subscriber.all
      get '/subscribers'
    end
    it 'returns all subs' do
      expect(JSON.parse(response.body).size).to eq(@subscribers.size)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'DELETE /destroy' do
    before do
      @subscriber = Subscriber.first
      delete "/subscribers/#{@subscriber.id}"
    end
    it 'returns true flag' do
      expect(JSON.parse(response.body)['flag']).to eq(true)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /show' do
    before do
      @subscriber = Subscriber.first
      resp = Geocoder.search([@subscriber.latitude, @subscriber.longitude])
      @details = resp.first
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.data['lat']}&lon=#{@details.data['lon']}&units=metric&appid=#{ENV['open_weather_api_key']}"
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      @weather_info = JSON.parse(res.body)
      get "/subscribers/#{@subscriber.id}"
    end
    it 'returns subscriber' do
      expect(JSON.parse(response.body)['details']['data']['lat']).to eq(@details.data['lat'])
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /unsubscribe' do
    before do
      @subscriber = Subscriber.first

      get "/subscribers/unsubscribe?email=#{@subscriber.email}"
    end
    it 'returns true flag' do
      expect(JSON.parse(response.body)['flag']).to eq(true)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
