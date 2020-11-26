# UCAS_OverFlow 静态页面
# author: wzl

class StaticPagesController < ApplicationController
  # 主页展示
  def home
    @text_blogs = TextBlog.order(click_count: :DESC).limit(10)
  end
end
