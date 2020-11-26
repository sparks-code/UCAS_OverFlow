class AccountActivationsController < ApplicationController
  include SessionsHelper

  def activate_page
    user = User.find_by(:id => params[:activate_id])
    if user 
      if user.activated
        redirect_to login_url
      else
        UserMailer.account_activation(user).deliver_now
      end
    else
      redirect_to login_url
    end
  end

  def activate_account
    user = User.find_by(:email => params[:email])
    user.new_email=nil
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_columns(activated: true, activated_at: Time.now)
      
      login_out

      redirect_to login_url
    else
      redirect_to activate_url(:activate_id=>user.id)
    end

    return
  end

  def activate_new_page
    user = User.find_by(:id => params[:activate_id])
    if user.new_email
      UserMailer.new_account_activation(user).deliver_now
    else
      flash[:error] = "查找待激活邮箱时发生错误，您可以再次尝试"
      redirect_to user
    end
  end

  def activate_new_account
    user = User.find_by(:email => params[:email])
    if user && user.activated? && user.authenticated?(:activation, params[:token]) && user.new_email
      user.email=user.new_email
      user.new_email=nil
      if user.save
        login_out
        redirect_to login_url
        return
      end    
    end

    flash[:error]="更新邮箱出错"
    redirect_to user
    return
  end

end
