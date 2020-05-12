require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get posts" do
    get get_forum_url
    assert_response :redirect
  end
end
