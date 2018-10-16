require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'requires a value' do
    v = Vote.new(voter: Voter.first, venue: Venue.first)
    assert_not v.save
    v.value = 1
    assert v.save
  end

  test 'accepts a value of 1, 0, or -1' do
    v = Vote.new(voter: Voter.first, venue: Venue.first)
    v.value = 1
    assert v.save
    v.value = -1
    assert v.save
    v.value = 0
    assert v.save
  end


  test 'does not accept a value greater than 1' do
    v = Vote.new(voter: Voter.first, venue: Venue.first)

    2.upto(200) do |unacceptable_value|
      v.value = unacceptable_value
      assert_not v.save
    end

  end

  test 'does not accept a value less than -1' do
    v = Vote.new(voter: Voter.first, venue: Venue.first)

    -2.downto(-200) do |unacceptable_value|         
      v.value = unacceptable_value
      assert_not v.save
    end

  end

end
