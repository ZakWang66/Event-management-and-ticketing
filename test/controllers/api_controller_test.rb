require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get getEvents" do
    get get_events_url
    assert_response :redirect
  end

end
