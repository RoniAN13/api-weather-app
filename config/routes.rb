# frozen_string_literal: true

Rails.application.routes.draw do
  get 'subscribers/unsubscribe'

  get 'static_pages/user_location_weather'
  resources :searched_cities
  resources :subscribers

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#user_location_weather'
end
