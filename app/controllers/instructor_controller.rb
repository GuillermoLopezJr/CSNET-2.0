class InstructorController < ApplicationController
  def new
  end
  
      
  def index
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = Course.where( instructor_id: @instructor)
      #render html: 'you are signed in'
    else  
      redirect_to sign_in_path
    end
  end
  

end
