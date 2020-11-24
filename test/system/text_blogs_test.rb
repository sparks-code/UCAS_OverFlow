require "application_system_test_case"

class TextBlogsTest < ApplicationSystemTestCase
  setup do
    @text_blog = text_blogs(:one)
  end

  test "visiting the index" do
    visit text_blogs_url
    assert_selector "h1", text: "Text Blogs"
  end

  test "creating a Text blog" do
    visit text_blogs_url
    click_on "New Text Blog"

    fill_in "Accessment", with: @text_blog.accessment
    fill_in "Click count", with: @text_blog.click_count
    fill_in "Content", with: @text_blog.content
    fill_in "File transfer", with: @text_blog.file_transfer_id
    fill_in "Response count", with: @text_blog.response_count
    fill_in "Tag", with: @text_blog.tag
    fill_in "Title", with: @text_blog.title
    fill_in "User", with: @text_blog.user_id
    click_on "Create Text blog"

    assert_text "Text blog was successfully created"
    click_on "Back"
  end

  test "updating a Text blog" do
    visit text_blogs_url
    click_on "Edit", match: :first

    fill_in "Accessment", with: @text_blog.accessment
    fill_in "Click count", with: @text_blog.click_count
    fill_in "Content", with: @text_blog.content
    fill_in "File transfer", with: @text_blog.file_transfer_id
    fill_in "Response count", with: @text_blog.response_count
    fill_in "Tag", with: @text_blog.tag
    fill_in "Title", with: @text_blog.title
    fill_in "User", with: @text_blog.user_id
    click_on "Update Text blog"

    assert_text "Text blog was successfully updated"
    click_on "Back"
  end

  test "destroying a Text blog" do
    visit text_blogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Text blog was successfully destroyed"
  end
end
