class SessionsController < ApplicationController
  include SessionsHelper

  def new
    # 已经登录则直接跳转到用户详情页
    redirect_to current_user if logged_in?
  end

  def create
    # 通过学号或邮箱查询用户
    user = User.find_by_email(params[:session][:account]) || User.find_by_user_number(params[:session][:account])

    if user && user.authenticate(params[:session][:password])
      if !login_in(user)
        return
      end
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      redirect_back_by_default(user)
    else
      flash.now[:warning] = "登录失败，用户名/密码错误！"
      render :new
    end
  end

  def destroy
    login_out if logged_in?
    redirect_to :login
  end
end
