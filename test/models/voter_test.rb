require 'test_helper'

class VoterTest < ActiveSupport::TestCase
  test "requires a first name" do
    v = Voter.first
    v.first_name = nil
    assert_not v.valid?
  end

  test "requires a last name" do
    v = Voter.first
    v.last_name = nil
    assert_not v.valid?
  end
end
