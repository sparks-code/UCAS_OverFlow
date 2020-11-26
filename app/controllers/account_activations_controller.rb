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

  def edit
    user = User.find_by(:email => params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_columns(activated: true, activated_at: Time.now)

      redirect_to login_url
    else
      redirect_to activate_url(:activate_id=>user.id)
    end
  end

end
