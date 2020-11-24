json.extract! resource_blog, :id, :title, :tag, :response_count, :click_count, :accessment, :user_id, :file_transfer_id, :created_at, :updated_at
json.url resource_blog_url(resource_blog, format: :json)
