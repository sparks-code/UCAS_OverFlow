class UsersController < ApplicationController
  include SessionsHelper

  before_action :ensure_logged_in, except: [:new, :create]  # 除了新建用户，任何操作都要求登录

  def index
    @users=nil
    if current_user && current_user.admin?
      @users = User.paginate(page: params[:page])
    else
      flash[:warning] = "非管理员无权限！为您自动重定向到个人详情页"
      redirect_to current_user
    end
  end

  def show
    @user = User.find(params[:id].to_i)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id].to_i)
  end

  def create
    @user = User.new(user_params)
    unless @user.save
      render '/users/new'
    else
      login_in(@user)
      redirect_to login_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def set_admin
    user = User.find_by(id: params[:user_id].to_i)
    if current_user != user && current_user.admin?
      user.admin ? user.admin = false : user.admin = true
      user.save
    else
      flash[:error] = "检查登录信息出错"
    end
    redirect_to users_url
  end

  def destroy
    user = User.find_by(id: params[:id].to_i)
    if current_user != user && current_user.admin?
        flash[:success] = "删除用户：{姓名：#{user.name}, 学号：#{user.user_number}, 邮箱:#{user.email}}成功"
        user.destroy
    else
        flash[:error] = "不允许删除当前用户"
    end
    redirect_to users_url
  end

  private
    def ensure_logged_in
      unless logged_in?
        store_forwarding_url
          
        flash[:warning] = "请先登录！"
        redirect_to login_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :user_number, :email, :password, :password_confirmation, :sex)    # 管理员信息不在此处设置
    end
end
