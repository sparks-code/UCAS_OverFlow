require 'test_helper'

class VideoReplysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get video_replys_new_url
    assert_response :success
  end

  test "should get edit" do
    get video_replys_edit_url
    assert_response :success
  end

end
