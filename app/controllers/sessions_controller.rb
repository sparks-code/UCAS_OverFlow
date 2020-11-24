class SessionsController < ApplicationController
  def new
  end

  def create
    # 请在下面完成要求的功能
    #*********begin*********#
    user = User.find_by(email: params[:session][:email])
      if @user.nil?
        # 用户不存在
        flash.now[:danger] = "登录失败，用户名/密码错误！"
        render "new"
      else
        unless user.authenticate(params[:session][:password])
          flash.now[:danger] = "登录失败，用户名/密码错误！"
          render "new"
        else
          flash.now[:success] = "登录成功！"  
          render "new" 
        end
      end

    #********* end *********#
  end
end
