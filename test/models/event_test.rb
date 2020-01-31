require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "event has many users" do
    assert_equal 2, Event.first.users.length
  end

  test "event has multiple pictures" do
    assert_equal 2, Event.first.pictures.length
  end

  test "event has multiple videos" do
    assert_equal 2, Event.first.videos.length
  end

  test "event organizers scope" do 
    assert_equal 2, Event.with_organizers.length
  end
end
