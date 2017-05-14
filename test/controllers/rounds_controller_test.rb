require 'test_helper'

class RoundsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rounds_index_url
    assert_response :success
  end

end
