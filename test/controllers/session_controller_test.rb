require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get googleAuth" do
    get session_googleAuth_url
    assert_response :success
  end

  test "should get signOut" do
    get session_signOut_url
    assert_response :success
  end

  test "should get signIn" do
    get session_signIn_url
    assert_response :success
  end

end
