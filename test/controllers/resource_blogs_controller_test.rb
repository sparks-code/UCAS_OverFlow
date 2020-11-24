require 'test_helper'

class ResourceBlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_blog = resource_blogs(:one)
  end

  test "should get index" do
    get resource_blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_blog_url
    assert_response :success
  end

  test "should create resource_blog" do
    assert_difference('ResourceBlog.count') do
      post resource_blogs_url, params: { resource_blog: { accessment: @resource_blog.accessment, click_count: @resource_blog.click_count, file_transfer_id: @resource_blog.file_transfer_id, response_count: @resource_blog.response_count, tag: @resource_blog.tag, title: @resource_blog.title, user_id: @resource_blog.user_id } }
    end

    assert_redirected_to resource_blog_url(ResourceBlog.last)
  end

  test "should show resource_blog" do
    get resource_blog_url(@resource_blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_blog_url(@resource_blog)
    assert_response :success
  end

  test "should update resource_blog" do
    patch resource_blog_url(@resource_blog), params: { resource_blog: { accessment: @resource_blog.accessment, click_count: @resource_blog.click_count, file_transfer_id: @resource_blog.file_transfer_id, response_count: @resource_blog.response_count, tag: @resource_blog.tag, title: @resource_blog.title, user_id: @resource_blog.user_id } }
    assert_redirected_to resource_blog_url(@resource_blog)
  end

  test "should destroy resource_blog" do
    assert_difference('ResourceBlog.count', -1) do
      delete resource_blog_url(@resource_blog)
    end

    assert_redirected_to resource_blogs_url
  end
end
