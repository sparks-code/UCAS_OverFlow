class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(:to => user.email, :subject => "激活您的账户-UCAS Overflow" )
  end
end
