require 'test_helper'

class ConfigsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get configs_index_url
    assert_response :success
  end

  test "should get new" do
    get configs_new_url
    assert_response :success
  end

  test "should get update" do
    get configs_update_url
    assert_response :success
  end

  test "should get edit" do
    get configs_edit_url
    assert_response :success
  end

  test "should get create" do
    get configs_create_url
    assert_response :success
  end

end
