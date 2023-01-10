# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /user_weather_location' do
    before do
      get '/static_pages/user_location_weather'
    end
    it 'returns user weather location' do
      expect(JSON.parse(response.body)['details']).to have_key('all')
      expect(JSON.parse(response.body)['weather_info']).to have_key('weather')
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
