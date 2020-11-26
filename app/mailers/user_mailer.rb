class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    ensure_activate_token_enable(user)
    mail(:to => user.email, :subject => "激活您的账户-UCAS Overflow" )
  end

  def new_account_activation(user)
    @user = user
    ensure_activate_token_enable(user)
    mail(:to => user.email, :subject => "更新您的邮箱-UCAS Overflow" )
  end

  # 确保内存中存储了token
  def ensure_activate_token_enable(user)
    if !user.activation_token
      user.create_activation_token
      user.save
    end
  end
end
