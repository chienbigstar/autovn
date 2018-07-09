require 'test_helper'

class LvcControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lvc_index_url
    assert_response :success
  end

end
