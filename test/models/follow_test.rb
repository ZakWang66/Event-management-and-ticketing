require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "follow has a follower" do
    assert_not_equal nil, Follow.first.follower
  end
  test "follow has a followee" do
    assert_not_equal nil, Follow.first.followee
  end
end
