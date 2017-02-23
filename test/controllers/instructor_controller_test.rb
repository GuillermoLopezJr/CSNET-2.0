require 'test_helper'

class InstructorControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get instructor_new_url
    assert_response :success
  end

  test "should get create" do
    get instructor_create_url
    assert_response :success
  end

end
