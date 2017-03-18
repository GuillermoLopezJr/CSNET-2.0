class StudentController < ApplicationController
  def new
  end
  
  def index
    if student_signed_in?
      #@instructor = current_instructor
      #@courses = Course.where( instructor_id: @instructor)
    else
      #redirect_to sign_in_path
    end
  end
  
  def show
    if student_signed_in?
      @student = current_student
      @courses = @student.courses
    else  
      #redirect_to sign_in_path
    end
  end

end
