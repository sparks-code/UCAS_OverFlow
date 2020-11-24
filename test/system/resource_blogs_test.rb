require "application_system_test_case"

class ResourceBlogsTest < ApplicationSystemTestCase
  setup do
    @resource_blog = resource_blogs(:one)
  end

  test "visiting the index" do
    visit resource_blogs_url
    assert_selector "h1", text: "Resource Blogs"
  end

  test "creating a Resource blog" do
    visit resource_blogs_url
    click_on "New Resource Blog"

    fill_in "Accessment", with: @resource_blog.accessment
    fill_in "Click count", with: @resource_blog.click_count
    fill_in "File transfer", with: @resource_blog.file_transfer_id
    fill_in "Response count", with: @resource_blog.response_count
    fill_in "Tag", with: @resource_blog.tag
    fill_in "Title", with: @resource_blog.title
    fill_in "User", with: @resource_blog.user_id
    click_on "Create Resource blog"

    assert_text "Resource blog was successfully created"
    click_on "Back"
  end

  test "updating a Resource blog" do
    visit resource_blogs_url
    click_on "Edit", match: :first

    fill_in "Accessment", with: @resource_blog.accessment
    fill_in "Click count", with: @resource_blog.click_count
    fill_in "File transfer", with: @resource_blog.file_transfer_id
    fill_in "Response count", with: @resource_blog.response_count
    fill_in "Tag", with: @resource_blog.tag
    fill_in "Title", with: @resource_blog.title
    fill_in "User", with: @resource_blog.user_id
    click_on "Update Resource blog"

    assert_text "Resource blog was successfully updated"
    click_on "Back"
  end

  test "destroying a Resource blog" do
    visit resource_blogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Resource blog was successfully destroyed"
  end
end
