require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  test "should require a name" do
    v = Venue.new
    assert_not v.save
  end

  test "can tell you it's own karma count" do
    v = Venue.first
    assert_not v.karma.nil?
  end

  test "sums its votes to get karma" do
    v = Venue.first
    k = v.karma

    v.votes.create({value: -1, voter: Voter.first})
    assert v.karma == (k - 1)

    v.votes.create({value: -1, voter: Voter.first})
    assert v.karma == (k - 2)

    v.votes.create({value: 1, voter: Voter.first})
    assert v.karma == (k - 1)

    v.votes.create({value: 1, voter: Voter.first})
    assert v.karma == k

    v.votes.create({value: 1, voter: Voter.first})
    assert v.karma == k + 1
  end

end
