require 'roo'
class InstructorController < ApplicationController

  def new
    @instructor = current_instructor
  
    if (!@instructor.is_admin)
      redirect_to root_path
    end 
    #@courses = @instructor.courses#where( instructor_id: @instructor)
  end

  def create
    Instructor.create!(instructor_params)
    redirect_to root_path
    #@course = current_instructor.courses.find_by number: (params[:assignment][:course_num].to_i)
      
    #if (@course != nil)
    #  @assignment = @course.assignments.create(assignment_params)
    #  redirect_to @assignment
    #else
    #  redirect_to assignments_path
    #end
  end
  
  
  
  def index
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
    else
      redirect_to root_path
    end
  end
  
  def show
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
    else  
      redirect_to root_path
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
  

  private
    def instructor_params
      params.require(:instructor).permit(:email, :password, :password_confirmation)
    end
 
end
