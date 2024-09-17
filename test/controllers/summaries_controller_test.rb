require "test_helper"

class SummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get summaries_create_url
    assert_response :success
  end
end
