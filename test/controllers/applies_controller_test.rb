require 'test_helper'

class AppliesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get appllies" do
    get get_applications_url
    assert_response :redirect
  end
end
