require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get code" do
    get requests_code_url
    assert_response :success
  end

end
