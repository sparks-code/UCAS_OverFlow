require 'test_helper'

class VideoBlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_blog = video_blogs(:one)
  end

  test "should get index" do
    get video_blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_video_blog_url
    assert_response :success
  end

  test "should create video_blog" do
    assert_difference('VideoBlog.count') do
      post video_blogs_url, params: { video_blog: { accessment: @video_blog.accessment, click_count: @video_blog.click_count, file_transfer_id: @video_blog.file_transfer_id, response_count: @video_blog.response_count, tag: @video_blog.tag, title: @video_blog.title, user_id: @video_blog.user_id } }
    end

    assert_redirected_to video_blog_url(VideoBlog.last)
  end

  test "should show video_blog" do
    get video_blog_url(@video_blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_video_blog_url(@video_blog)
    assert_response :success
  end

  test "should update video_blog" do
    patch video_blog_url(@video_blog), params: { video_blog: { accessment: @video_blog.accessment, click_count: @video_blog.click_count, file_transfer_id: @video_blog.file_transfer_id, response_count: @video_blog.response_count, tag: @video_blog.tag, title: @video_blog.title, user_id: @video_blog.user_id } }
    assert_redirected_to video_blog_url(@video_blog)
  end

  test "should destroy video_blog" do
    assert_difference('VideoBlog.count', -1) do
      delete video_blog_url(@video_blog)
    end

    assert_redirected_to video_blogs_url
  end
end
