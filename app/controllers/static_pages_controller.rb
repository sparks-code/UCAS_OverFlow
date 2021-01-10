# UCAS_OverFlow 静态页面
# author: wzl

class StaticPagesController < ApplicationController
  include UsersHelper
  include SessionsHelper

  before_action :set_background_disable
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
    @hotest_blogs = @hotest_blogs[0, 10]
    @cur_user = current_user()
    @user_url = ''
    if @cur_user!= nil
      @user_url = user_url(current_user.id)
    else
      @user_url = "/login"
    end

    @login_action = ''
    @login_action_url = ""
    if @cur_user!= nil
      @login_action = "退出"
      @login_action_url = "/login_out_for_home"
    else
      @login_action = "登录"
      @login_action_url = "/login"
    end

    
    

  end

  def login_out_for_home
    login_out
    redirect_to "/home"
  end


  private
    def set_background_disable
      $user_background = false
    end
end
