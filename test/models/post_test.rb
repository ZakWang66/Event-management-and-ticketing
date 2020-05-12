require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "post has a event" do
    assert_not_equal nil, Post.first.event_id
  end
  test "post has a content" do
    assert_not_equal nil, Post.first.content
  end
  test "post has a user" do
    assert_not_equal nil, Post.first.user_id
  end
end
