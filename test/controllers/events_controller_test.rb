require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get events" do
    get get_events_url
    assert_response :redirect
  end
end
