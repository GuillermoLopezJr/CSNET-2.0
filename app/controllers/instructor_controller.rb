require 'roo'
class InstructorController < ApplicationController

  def new
  end
  
  def index
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = Course.where( instructor_id: @instructor)
    else
      redirect_to sign_in_path
    end
  end
  
  def show
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = Course.where( instructor_id: @instructor)
    else  
      render html: "user not signed in"
      #redirect_to sign_in_path
    end
  end
  
  def parseXLSX 
    return 'f'
  end
  helper_method :parseXLSX
  
  

end
