class AccountActivationsController < ApplicationController
  include SessionsHelper

  before_action :set_background_enable, only: [:activate_page, :activate_login_page, :activate_new_page]
  after_action :set_background_disable, only: [:activate_page, :activate_login_page, :activate_new_page]

  def activate_page
    user = User.find_by(:id => params[:activate_id])
    if user 
      if user.activated
        redirect_to login_url
      else
        begin
          UserMailer.account_activation(user).deliver_now
        rescue
          flash[:error]="发送邮件出错，请检查您的邮箱是否有效"
          redirect_to login_url
          return
        end
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
      begin
        UserMailer.new_account_activation(user).deliver_now
      rescue
        flash[:error]="发送邮件出错，请检查您的邮箱是否有效"
        redirect_to user
        return
      end
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
        old_users = User.where(:new_email=>user.email)
        if old_users
          old_users.each do |old_user|
            old_user.new_email=nil
            old_user.save
          end
        end

        login_out
        redirect_to login_url
        return
      end    
    end

    flash[:error]="更新邮箱出错,可能在此期间邮箱被您再次注册为新用户"
    redirect_to user
    return
  end

  def activate_login_page
    @user = User.find_by(:id => params[:login_id])
    if @user.email
      begin
        UserMailer.email_login_activation(@user).deliver_now
      rescue
        flash[:error]="发送邮件出错，请检查您的邮箱是否有效"
        redirect_to email_login_url
        return
      end
    else
      flash[:error] = "查找邮箱时发生错误，您可以再次尝试"
      redirect_to email_login_url
    end
  end

  private
    def set_background_enable
      $user_background = true
    end

    def set_background_disable
      $user_background = false
    end
end
