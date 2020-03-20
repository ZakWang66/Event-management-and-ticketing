require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get getEvents" do
    get api_getEvents_url
    assert_response :success
  end

end
