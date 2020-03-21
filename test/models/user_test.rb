require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "users has many events" do
    assert_equal 2, User.first.events.length
  end

  test "event organizers scope" do 
    assert_equal 2, User.with_organizers.length
  end
end
