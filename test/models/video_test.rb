require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  self.use_instantiated_fixtures = true
  test "has an event" do
    assert_equal "snowboard", @video_one.event.title
  end
end
