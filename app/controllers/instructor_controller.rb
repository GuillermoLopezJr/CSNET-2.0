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
    end
  end

  def create
    Instructor.create!(instructor_params)
    redirect_to root_path
  end
  
  
  def index
    redirect_to root_path
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
    end
  end
  

  private
    def instructor_params
      params.require(:instructor).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
 
end
