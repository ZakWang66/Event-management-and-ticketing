require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest
  # test "should get follow" do
  #   get follows_follow_url
  #   assert_response :success
  # end
  test "should get follows" do
    get get_follows_url
    assert_response :redirect
  end
end
