require "application_system_test_case"

class FileTransfersTest < ApplicationSystemTestCase
  setup do
    @file_transfer = file_transfers(:one)
  end

  test "visiting the index" do
    visit file_transfers_url
    assert_selector "h1", text: "File Transfers"
  end

  test "creating a File transfer" do
    visit file_transfers_url
    click_on "New File Transfer"

    fill_in "File path", with: @file_transfer.file_path
    fill_in "Introduction", with: @file_transfer.introduction
    click_on "Create File transfer"

    assert_text "File transfer was successfully created"
    click_on "Back"
  end

  test "updating a File transfer" do
    visit file_transfers_url
    click_on "Edit", match: :first

    fill_in "File path", with: @file_transfer.file_path
    fill_in "Introduction", with: @file_transfer.introduction
    click_on "Update File transfer"

    assert_text "File transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a File transfer" do
    visit file_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "File transfer was successfully destroyed"
  end
end
