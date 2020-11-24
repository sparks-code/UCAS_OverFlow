require 'test_helper'

class FileTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_transfer = file_transfers(:one)
  end

  test "should get index" do
    get file_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_file_transfer_url
    assert_response :success
  end

  test "should create file_transfer" do
    assert_difference('FileTransfer.count') do
      post file_transfers_url, params: { file_transfer: { file_path: @file_transfer.file_path, introduction: @file_transfer.introduction } }
    end

    assert_redirected_to file_transfer_url(FileTransfer.last)
  end

  test "should show file_transfer" do
    get file_transfer_url(@file_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_file_transfer_url(@file_transfer)
    assert_response :success
  end

  test "should update file_transfer" do
    patch file_transfer_url(@file_transfer), params: { file_transfer: { file_path: @file_transfer.file_path, introduction: @file_transfer.introduction } }
    assert_redirected_to file_transfer_url(@file_transfer)
  end

  test "should destroy file_transfer" do
    assert_difference('FileTransfer.count', -1) do
      delete file_transfer_url(@file_transfer)
    end

    assert_redirected_to file_transfers_url
  end
end
