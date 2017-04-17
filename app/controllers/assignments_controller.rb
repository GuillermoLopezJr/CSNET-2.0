class AssignmentsController < ApplicationController
  def new
    @instructor = current_instructor
    @courses = @instructor.courses#where( instructor_id: @instructor)
  end

  def create
    @course = current_instructor.courses.find_by number: (params[:assignment][:course_num].to_i)
      
    if (@course != nil)
      @assignment = @course.assignments.create(assignment_params)
      redirect_to @assignment, notice: "The assignment #{@assignment.name} has been created."
    else
      redirect_to assignments_path, danger: "Could not create #{params[:assignment][:name]}."
      #redirect_to assignments_path, notice: "Could not create #{@assignment.name}."
    end
  end
  
  
  def index
    #need to distinguish between student and instructor
    
    @isInstructor = true
    @isStudent    = true
    @isAssistant  = true
   
    if ( student_signed_in? )
      #a student is signed in
      @user = current_student
      @isInstructor = false
      @isAssistant  = false
      
    elsif( instructor_signed_in? )
      #an instructor is singed in
      @user = current_instructor
      @isStudent    = false
      @isAssistant  = false
      
    elsif( assistant_signed_in? )
      #an assistant is signed in
      @user = current_assistant
      @isInstructor = false
      @isStudent    = false
        
    else 
      redirect_to root_path
    end
    
    @courses = @user.courses
    @courses.each do |course|
      if (@assignments == nil)
        @assignments = course.assignments.all
      else
        @assignments = @assignments + course.assignments.all
      end
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
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

  def edit
    @instructor = current_instructor
    @courses = Course.where( instructor_id: @instructor)
    @assignment = Assignment.find(params[:id])
  end
  
  def update
    @instructor = current_instructor
    @courses = Course.where( instructor_id: @instructor)
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
       redirect_to @assignment
    else
       render 'edit'
    end
  end
    
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to assignments_path, notice:  "The assignment #{@assignment.name} has been deleted."
  end

    
  private
    def assignment_params
      params.require(:assignment).permit(:name, :due_date, :course_num, :attachment)
    end
end
