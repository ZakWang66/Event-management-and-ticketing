require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "participant has a user" do
    assert_not_equal nil, Participant.first.user
  end
  test "participant has a event" do
    assert_not_equal nil, Participant.first.event
  end
  test "participant has a role" do
    assert_not_equal nil, Participant.first.role
  end
end
