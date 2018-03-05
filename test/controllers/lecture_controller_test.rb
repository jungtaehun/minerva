require 'test_helper'

class LectureControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get lecture_info_url
    assert_response :success
  end

end
