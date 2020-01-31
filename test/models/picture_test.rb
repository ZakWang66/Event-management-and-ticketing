require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  self.use_instantiated_fixtures = true
  test "has an event" do
    assert_equal "snowboard", @picture_one.event.title
  end
end
