require "test_helper"

class BetControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bet_new_url
    assert_response :success
  end

  test "should get create" do
    get bet_create_url
    assert_response :success
  end

  test "should get edit" do
    get bet_edit_url
    assert_response :success
  end

  test "should get update" do
    get bet_update_url
    assert_response :success
  end

  test "should get destroy" do
    get bet_destroy_url
    assert_response :success
  end
end
