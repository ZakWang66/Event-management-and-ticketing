require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get users" do
    get users_url + "1"
    assert_response :redirect
  end
end
