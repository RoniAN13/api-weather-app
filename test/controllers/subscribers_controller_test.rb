# frozen_string_literal: true

require 'test_helper'

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get subscribers_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get subscribers_destroy_url
    assert_response :success
  end

  test 'should get unsubscribe' do
    get subscribers_unsubscribe_url
    assert_response :success
  end
end
