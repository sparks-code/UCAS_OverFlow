class SessionsController < ApplicationController
  include SessionsHelper

  def new
    # 已经登录则直接跳转到用户详情页
    redirect_to current_user if logged_in?

    @current_url= login_url
  end

  def email_login
    # 已经登录则直接跳转到用户详情页
    redirect_to current_user if logged_in?
  end

  def create
    @current_url= login_url
    # 通过学号或邮箱查询用户
    user = User.find_by_email(params[:session][:account]) || User.find_by_user_number(params[:session][:account])

    if user && user.authenticate(params[:session][:password])
      if !login_in(user)
        return    # 内部跳转到激活验证界面了
      end
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      redirect_back_by_default(root_url)
    else
      flash.now[:warning] = "登录失败，用户名/密码错误！"
      render :new
    end
  end

  def deal_email_login
    # 通过学号或邮箱查询用户
    user = User.find_by_email(params[:session][:account]) || User.find_by_user_number(params[:session][:account])

    if !user
      flash[:error]="用户不存在"
      render :email_login
      return
    end

    if !user.activated
      # 跳转到激活验证界面了
      redirect_to activate_url(:activate_id=>user.id)
      return 
    else
      redirect_to activate_login_url(:login_id=>user.id)
      return
    end
  end

  def validates_email_login
    # 通过学号或邮箱查询用户
    user = User.find_by(:id=>params[:login_id].to_i)

    if user && user.authenticated?(:login, params[:token])
      user.disable_login_token
      if !login_in(user)
        return    # 内部跳转到激活验证界面了
      end
      redirect_back_by_default(root_url)
    else
      flash[:warning] = "您可能使用了过时的登录邮件，可尝试再次发送"
      redirect_to email_login_url
    end
  end

  def destroy
    login_out if logged_in?
    redirect_to :login
  end
end
