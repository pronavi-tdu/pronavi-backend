require "test_helper"

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get updata" do
    get schedules_updata_url
    assert_response :success
  end
end
