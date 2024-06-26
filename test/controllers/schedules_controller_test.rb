require "test_helper"

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get schedules_register_url
    assert_response :success
  end

  test "should get index" do
    get schedules_index_url
    assert_response :success
  end

  test "should get update" do
    get schedules_update_url
    assert_response :success
  end
end
