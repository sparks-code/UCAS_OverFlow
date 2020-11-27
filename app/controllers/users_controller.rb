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
    if current_user.admin || current_user.id == params[:id].to_i
      @user = User.find(params[:id].to_i)
    else
      @user = current_user
    end

    if !@user.is_effective?

      # 强制非法访问时，返回空白信息
      @user = current_user
    end
  end

  def new
    @is_new_user=true
    @user = User.new
  end

  def edit
    @is_new_user=false
    @user = User.find_by(id: params[:id].to_i)
  end

  def create
    @user = User.new(user_params)
    debugger
    unless @user.save
      flash[:error]
      @is_new_user=true
      render '/users/new'
    else
      redirect_to activate_url(:activate_id=>user.id)
    end
  end

  def update
    @user = User.find(params[:id])

    # 判断待更新邮箱是否存在
    if User.find_by(:email=>params[:user][:new_email])
      flash.now[:error]="新邮箱已经被注册"
      @is_new_user=false
      render 'edit'
      return
    end

    if @user.update_attributes(user_params)

      if @user.new_email && @user.new_email !=@user.email
        redirect_to activate_new_url(:activate_id=>@user.id)
      else
        @user.new_email=nil
        @user.save
        redirect_to root_url
      end
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

        #  实际上只是转化为未激活状态，并删除邮箱和学号信息
        user.user_number=nil
        user.email=nil
        user.activated =false
        user.save
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

    # 参数过滤器
    def user_params
      params.require(:user).permit(:name, :user_number, :email, :new_email, :password, :password_confirmation, :sex)    # 管理员信息不在此处设置
    end
end
