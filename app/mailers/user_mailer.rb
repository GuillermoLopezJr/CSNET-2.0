class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'https://fast-shore-41666.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to CSNET 2.0')
  end
end
