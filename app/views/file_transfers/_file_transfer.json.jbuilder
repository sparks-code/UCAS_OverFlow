json.extract! file_transfer, :id, :file_path, :introduction, :created_at, :updated_at
json.url file_transfer_url(file_transfer, format: :json)
