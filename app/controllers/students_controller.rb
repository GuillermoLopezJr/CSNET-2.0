class StudentsController < ApplicationController

  # used for the new student form
  def new
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    @instructor = current_instructor
    @courses = @instructor.courses
  end
  
  
  # used when showing an individual student's home page
  def show
    if student_signed_in?
      @student = current_student
      @isStudent = true
      #render html: @student.course_id
      @courses = @student.courses
    else  
      redirect_to sign_in_path
    end
  end


  # Used when an instructor submits a new student form
  def create
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    
    # Checks that the email is in fact an email address
    if !(EmailValidator.valid?(params[:student][:email]))
      flash[:danger] = "Invalid Email Address."
      redirect_to students_path
      return
    end
    
    @instructor = current_instructor
    @course =  @instructor.courses.find_by( number: params[:student][:course_num] )
    
    # Check if that course exists
    @course = current_instructor.courses.where( number: params[:student][:course_num], year: params[:student][:course_year], session: params[:student][:course_session] ).first
    if (@course == nil) 
      flash[:danger] = "Could not add student because the corresponding course was not found."
      redirect_to students_path
      return
    end
    
    @student = Student.find_by( email: params[:student][:email] )
    
    # Should never happen
    if @course == nil
      redirect_to students_path
      return
    end
    
    # A new student is being created
    if @student == nil
      #Ensure students arent enrolled twice
      if @course.students.where( id: @student ).empty? 
        @student = @course.students.create!(student_params)
        if @student.save
           UserMailer.welcome_email(@student, @student.password).deliver_later
           puts '------'+  @student.first_name + ' Password ' +  @student.password.to_s
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
    flash[:success] = "Student #{@student.first_name} #{@student.last_name} has been created"
    redirect_to students_path
  end
  
  
  # used to show all students 
  def index
    @students = Student.all
    @instructor = current_instructor

    @isStudent = true
    @isInstructor = true
    @isAssistant = true
    
    if student_signed_in?
      @isInstructor = false
      @isAssistant = false
      
      redirect_to root_path
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
      @courses = @instructor.courses
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
