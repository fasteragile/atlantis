require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test "allows POST of a valid payload to /votes.json" do
    post '/votes.json', params: {"name":"Little House Inn","vote":1,"voter":{"first_name":"Peter","last_name":"Jackson"}}
    assert_response :success
  end

  test "POST of an invalid payload (no name) to /votes.json" do
    post '/votes.json', params: {"vote":1,"voter":{"first_name":"Peter","last_name":"Jackson"}}
    assert_response :unprocessable_entity
  end
end
