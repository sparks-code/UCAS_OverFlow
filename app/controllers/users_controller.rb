class UsersController < ApplicationController
  include SessionsHelper

  before_action :ensure_logged_in, except: [:new, :create]  # 除了新建用户，任何操作都要求登录

  def index
    @users = User.all
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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def ensure_logged_in
      unless logged_in?
        store_forwarding_url
          
        flash[:danger] = "请先登录！"
        redirect_to login_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :user_number, :email, :password, :password_confirmation, :sex)    # 管理员信息不在此处设置
    end
end
