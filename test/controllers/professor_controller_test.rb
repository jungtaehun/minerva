require 'test_helper'

class ProfessorControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get professor_info_url
    assert_response :success
  end

end
