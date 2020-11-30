class UsersController < ApplicationController
  include SessionsHelper
  include ActivateType

  before_action :ensure_logged_in, except: [:new, :create]  # 除了新建用户，任何操作都要求登录
  before_action :set_background_enable, only: [:new, :edit, :create, :update]
  after_action :set_background_disable, except: [:new, :edit, :create, :update]

  def show_user_videoblogs
    @blogs = current_user.video_blogs.paginate(page: params[:page], per_page: 12)

    @activate_type=ActivateType::MyVideosBlog
  end

  def show_user_textblogs
    @blogs = current_user.text_blogs.paginate(page: params[:page], per_page: 12)
    
    @activate_type=ActivateType::MyTextBlogs
  end

  def show_user_resourceblogs
    @blogs = current_user.resource_blog.paginate(page: params[:page], per_page: 12)
    
    @activate_type=ActivateType::MyResourceBlogs
  end

  def index
    @activate_type=ActivateType::ShowUsers
    @users=nil
    if current_user && current_user.admin?
      @users = User.paginate(page: params[:page],per_page: 12)
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
    @activate_type=ActivateType::UserInformation
  end

  def new
    @current_url= new_user_url
    @is_new_user=true
    @user = User.new
  end

  def edit
    @current_url= edit_user_url
    @is_new_user=false
    @user = User.find_by(id: params[:id].to_i)
    @activate_type=ActivateType::UpdateInformation
  end

  def create
    @current_url= new_user_url
    @user = User.new(user_params)
    unless @user.save
      @is_new_user=true
      # redirect_to new_user_url
      render :new
    else
      redirect_to activate_url(:activate_id=>@user.id)
    end
  end

  def update
    @current_url= edit_user_url
    @user = User.find(params[:id])

    # 判断待更新邮箱是否存在
    if User.find_by(:email=>params[:user][:new_email]) && @user.email != params[:user][:new_email]
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

    def set_background_enable
      $user_background = true
    end

    def set_background_disable
      $user_background = false
    end

    # 参数过滤器
    def user_params
      params.require(:user).permit(:name, :user_number, :email, :new_email, :password, :password_confirmation, :sex)    # 管理员信息不在此处设置
    end
end
