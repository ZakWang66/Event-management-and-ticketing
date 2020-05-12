require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get root_url
    assert_response :ok
  end
end
