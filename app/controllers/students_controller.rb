class StudentsController < ApplicationController

  def new
    @instructor = current_instructor
    @courses = @instructor.courses
  end
  
  def show
    if student_signed_in?
      @student = current_student
      @isStudent = true
      #render html: @student.course_id
      @courses = @student.courses
      #@courses = Course.where( student_id: @student.courses)
    else  
      render html: "user not signed in"
      #redirect_to sign_in_path
    end
  end


  def create
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
        if @student.save
           UserMailer.welcome_email(@student, @student.password).deliver_later
        else
          #could not send email
        end
        
      end
    #The student already exists
    else
      #Ensure students arent enrolled twice
      if @course.students.where( id: @student ).empty? 
        @course.students << @student
      end
    end
    redirect_to students_path, notice: "Student created"
  end
  
  
  def index
    @students = Student.all
    @instructor = current_instructor
    @courses = @instructor.courses

    @isStudent = true
    @isInstructor = true
    @isAssistant = true
    
    if student_signed_in?
      @isInstructor = false
      @isAssistant = false

      @submissions = Submission.all
      @student = current_student
      @courses = @student.courses
      @courses.each do |course|
        if (@assignments == nil)
          @assignments = course.assignments.all
        else
           @assignments = @assignments + course.assignments.all
         end
      end
  elsif (@isInstructor == true)
    @isStudent = false
    @isAssistant = false
  elsif (@isAssistant)
    @isStudent = false
    @isInstructor = false
  end


    
  end

  private
    def student_params
      #change password to something random initally
      password_length = 8
      pass = Devise.friendly_token.first(password_length)
      puts "pass is "
      puts pass
      params.require(:student).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(:password => pass, :password_confirmation => pass)
    end
end
