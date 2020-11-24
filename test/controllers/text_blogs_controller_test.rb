require 'test_helper'

class TextBlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_blog = text_blogs(:one)
  end

  test "should get index" do
    get text_blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_text_blog_url
    assert_response :success
  end

  test "should create text_blog" do
    assert_difference('TextBlog.count') do
      post text_blogs_url, params: { text_blog: { accessment: @text_blog.accessment, click_count: @text_blog.click_count, content: @text_blog.content, file_transfer_id: @text_blog.file_transfer_id, response_count: @text_blog.response_count, tag: @text_blog.tag, title: @text_blog.title, user_id: @text_blog.user_id } }
    end

    assert_redirected_to text_blog_url(TextBlog.last)
  end

  test "should show text_blog" do
    get text_blog_url(@text_blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_text_blog_url(@text_blog)
    assert_response :success
  end

  test "should update text_blog" do
    patch text_blog_url(@text_blog), params: { text_blog: { accessment: @text_blog.accessment, click_count: @text_blog.click_count, content: @text_blog.content, file_transfer_id: @text_blog.file_transfer_id, response_count: @text_blog.response_count, tag: @text_blog.tag, title: @text_blog.title, user_id: @text_blog.user_id } }
    assert_redirected_to text_blog_url(@text_blog)
  end

  test "should destroy text_blog" do
    assert_difference('TextBlog.count', -1) do
      delete text_blog_url(@text_blog)
    end

    assert_redirected_to text_blogs_url
  end
end
