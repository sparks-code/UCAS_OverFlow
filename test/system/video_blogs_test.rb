require "application_system_test_case"

class VideoBlogsTest < ApplicationSystemTestCase
  setup do
    @video_blog = video_blogs(:one)
  end

  test "visiting the index" do
    visit video_blogs_url
    assert_selector "h1", text: "Video Blogs"
  end

  test "creating a Video blog" do
    visit video_blogs_url
    click_on "New Video Blog"

    fill_in "Accessment", with: @video_blog.accessment
    fill_in "Click count", with: @video_blog.click_count
    fill_in "File transfer", with: @video_blog.file_transfer_id
    fill_in "Response count", with: @video_blog.response_count
    fill_in "Tag", with: @video_blog.tag
    fill_in "Title", with: @video_blog.title
    fill_in "User", with: @video_blog.user_id
    click_on "Create Video blog"

    assert_text "Video blog was successfully created"
    click_on "Back"
  end

  test "updating a Video blog" do
    visit video_blogs_url
    click_on "Edit", match: :first

    fill_in "Accessment", with: @video_blog.accessment
    fill_in "Click count", with: @video_blog.click_count
    fill_in "File transfer", with: @video_blog.file_transfer_id
    fill_in "Response count", with: @video_blog.response_count
    fill_in "Tag", with: @video_blog.tag
    fill_in "Title", with: @video_blog.title
    fill_in "User", with: @video_blog.user_id
    click_on "Update Video blog"

    assert_text "Video blog was successfully updated"
    click_on "Back"
  end

  test "destroying a Video blog" do
    visit video_blogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video blog was successfully destroyed"
  end
end
