class SessionsController < ApplicationController
  def new
    # no code
  end

  def create
    user = User.find_by(email: params[:session][:email])
      if user.nil?
        # 用户不存在
        flash.now[:danger] = "登录失败，用户不存在！"
        render "new"
      else
        unless user.authenticate(params[:session][:password])
          flash.now[:danger] = "登录失败，密码错误！"
          render "new"
        else
          flash.now[:success] = "登录成功！"  

          # 登录成功，重定向到首页，此处待修正
          redirect_to user_path(user.id)
        end
      end
  end
end
