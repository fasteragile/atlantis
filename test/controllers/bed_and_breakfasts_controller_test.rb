require 'test_helper'

class BedAndBreakfastsControllerTest < ActionDispatch::IntegrationTest
  test "it should get index" do
    get '/bed_and_breakfasts.json'
    assert_response :success
  end
end
