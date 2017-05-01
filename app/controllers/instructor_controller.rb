#require 'roo'
class InstructorController < ApplicationController

  def new
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
      @isInstructor = true
      @isStudent = false
      @isAssistant = false
    else 
      redirect_to root_path
      return
    end
  end

  def create
    
    # Checks that the email is in fact an email address
    if !(EmailValidator.valid?(params[:instructor][:email]))
      flash[:danger] = "Invalid Email Address and/or credentials."
      redirect_to instructor_index_path
      return
    end
    
    @instr = Instructor.create!(instructor_params)
    if @instr.save
       UserMailer.welcome_email(@instr, @instr.password).deliver_later
    else
      #could not send email
    end
    flash[:success] = "Instructor #{@instr.first_name} #{@instr.last_name} has been created"
    redirect_to instructor_index_path
  end
  
  
  def index
        # Only an admin has access to this information.  Ohter instructors will not get the link
        @instructor = Instructor.all
  end
  
  def show
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
      @isInstructor = true
      @isStudent = false
      @isAssistant = false
    else  
      redirect_to root_path
      return
    end
  end

  def download
    puts "here"
  end
  

  private
    def instructor_params
      password_length = 8
      pass = Devise.friendly_token.first(password_length)
      puts "pass is "
      params.require(:instructor).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(:password => pass, :password_confirmation => pass)
    end

end
