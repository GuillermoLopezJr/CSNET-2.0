require 'roo'
class InstructorController < ApplicationController

  def new
  end
  
  def index
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
    else
      redirect_to sign_in_path
    end
  end
  
  def show
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
    else  
      redirect_to sign_in_path
    end
  end

  def enrollStudent
    @instructor = current_instructor
    @courses = @instructor.courses
  end

  def addEnrolledStudent
    @instructor = current_instructor
    @course =  @instructor.courses.find_by( number: params[:enrollStudent][:course_num] ) #number: 463)#params[:course_num] )
    @student = Student.find_by( email: params[:enrollStudent][:student_email] )#email: 's1@gmail.com')#params[:student_email] )

    if ( @course != nil && @student != nil && @course.students.where( id: @student ).empty? ) 
      @course.students << @student
    end
    
    redirect_to @instructor
  end
 
end
