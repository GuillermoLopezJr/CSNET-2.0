class SessionsController < ApplicationController
  def new
  end
  
  def create 
    student = Student.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
    if student 
      session[:user_id] = student.id
      render html: params[:session][:email] 
      
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
#    render html: params[:session][:email]
  end 
  
  def destroy
  end
  
end
