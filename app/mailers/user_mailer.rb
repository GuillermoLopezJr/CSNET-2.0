class UserMailer < ApplicationMailer

  def welcome_email(user, pass)
    @user = user
    @url  = 'https://fast-shore-41666.herokuapp.com'
    @password = pass
    mail(to: @user.email, subject: 'Welcome to CSNET 2.0')
  end

  def ack_submission(user, submission, course, assignment)
    @user = user
    @submission = submission
    @course = course
    @assignment = assignment
    
    mail(to: @user.email, subject: 'This is your Turnitin Digit Receipt')
  end

end
