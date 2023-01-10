# frozen_string_literal: true

FactoryBot.define do
  factory :subscriber do
    email { 'example-1@gmail.com' }
    latitude { 45 }
    longitude { 45 }
  end
end
