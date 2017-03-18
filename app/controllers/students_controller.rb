class StudentsController < ApplicationController

  def new
    @instructor = current_instructor
    @courses = @instructor.courses
  end
  
  def show
    if student_signed_in?
      @student = current_student
      #render html: @student.course_id
      @courses = @student.courses
      #@courses = Course.where( student_id: @student.courses)
    else  
      render html: "user not signed in"
      #redirect_to sign_in_path
    end
  end


  def create
    #@course = Course.find_by number: (params[:student][:course_num].to_i)
    @instructor = current_instructor
    @course =  @instructor.courses.find_by( number: params[:student][:course_num] )
    @student = Student.find_by( email: params[:student][:email] )
    
    # Should never happen
    if @course == nil
      redirect_to students_path
    end
    
    # A new student is being created
    if @student == nil
      #Ensure students arent enrolled twice
      if @course.students.where( id: @student ).empty? 
        @student = @course.students.create!(student_params)
        @student.save
      end
    #The student already exists
    else
      #Ensure students arent enrolled twice
      if @course.students.where( id: @student ).empty? 
        @course.students << @student
      end
    end
    redirect_to students_path
  end

#    @student = @course.students.create(student_params)
#    render html: @student.course.number
#    @student.save
#    @course.save
    #redirect_to @student
    #redirect_to student_path(@student)
#    redirect_to students_path

    #@instructor = current_instructor
    #@courses = Course.where( instructor_id: @instructor)
    #@course = @courses.find_by number: (params[:student][:course_num].to_i) 

#    if (@course != nil)
      #@course.students.create(students_params);
      #@assignment = @course.assignments.create(assignment_params)
      #@student = @course.students.create(student_params)
    #  redirect_to students_path
#    else
#      #error course was not found?
    #  redirect_to course_path(@course)
#    end

#  end
  
  def index
    @students = Student.all
  end


  
  private
    def student_params
      #change password to something random initally
      password_length = 6
      pass = Devise.friendly_token.first(password_length)
      #puts "pass is "
      pass = "password"
      #puts pass
      params.require(:student).permit(:email, :password, :password_confirmation).merge(:password => pass, :password_confirmation => pass)
    end
end
