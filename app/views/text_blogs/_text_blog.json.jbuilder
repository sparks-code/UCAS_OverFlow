json.extract! text_blog, :id, :title, :tag, :content, :response_count, :click_count, :accessment, :user_id, :file_transfer_id, :created_at, :updated_at
json.url text_blog_url(text_blog, format: :json)
