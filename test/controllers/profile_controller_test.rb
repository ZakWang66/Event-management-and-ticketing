require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get profile_edit_url
    assert_response :success
  end

  test "should get changePwd" do
    get profile_changePwd_url
    assert_response :success
  end

  test "should get addFriend" do
    get profile_addFriend_url
    assert_response :success
  end

end
