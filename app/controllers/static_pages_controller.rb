# UCAS_OverFlow 静态页面
# author: wzl

class StaticPagesController < ApplicationController
  # 主页展示
  def home
    @text_blogs = TextBlog.order(click_count: :DESC).limit(10)
    # @video_blogs = VideoBlog.order(click_count: :DESC).paginate(page: params[:page])
    @video_blogs = VideoBlog.order(click_count: :DESC).limit(10)
    @resource_blogs = ResourceBlog.order(click_count: :DESC).limit(10)

    # hotest_blogs
    @hotest_blogs = Array.new
    @hotest_blogs = @hotest_blogs + @text_blogs
    @hotest_blogs = @hotest_blogs + @video_blogs
    @hotest_blogs = @hotest_blogs + @resource_blogs
    @hotest_blogs.sort!{|x, y| y.click_count <=> x.click_count}
  end

  def show

  end

  
end
