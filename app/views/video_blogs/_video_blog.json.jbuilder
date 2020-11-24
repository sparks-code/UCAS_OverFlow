json.extract! video_blog, :id, :title, :tag, :response_count, :click_count, :accessment, :user_id, :file_transfer_id, :created_at, :updated_at
json.url video_blog_url(video_blog, format: :json)
