class AssignmentsController < ApplicationController
  def new
    if not instructor_signed_in?
      redirect_to root_path
    end
    @instructor = current_instructor
    @courses = @instructor.courses
  end

  def create
    if not instructor_signed_in?
      redirect_to root_path
    end
    
    @course = current_instructor.courses.find_by number: (params[:assignment][:course_num].to_i)
      
    if (@course != nil)
      @assignment = @course.assignments.create(assignment_params)
      redirect_to @assignment, notice: "The assignment #{@assignment.name} has been created."
    else
      redirect_to assignments_path, danger: "Could not create #{params[:assignment][:name]}."
    end
  end
  
  
  def index
    #need to distinguish between student and instructor
    
    @isInstructor = false
    @isStudent    = false
    @isAssistant  = false
   
    if ( student_signed_in? )
      #a student is signed in
      @user = current_student
      @isStudent    = true
      
    elsif( instructor_signed_in? )
      #an instructor is singed in
      @user = current_instructor
      @isInstructor = true
      
    elsif( assistant_signed_in? )
      #an assistant is signed in
      @user = current_assistant
      @isAssistant = true
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
  end

  def edit
    if not instructor_signed_in?
      redirect_to root_path
    end
    @instructor = current_instructor
    @courses = @instructor.courses
    @assignment = Assignment.find(params[:id])
  end
  
  def update
    if not instructor_signed_in?
      redirect_to root_path
    end
    @instructor = current_instructor
    @courses = @instructor.courses
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
       redirect_to @assignment, notice: "The assignment #{@assignment.name} has been edited."
    else
       render 'edit', danger: "Could not edit #{params[:assignment][:name]}."
    end
  end
    
  def destroy
    if not instructor_signed_in?
      redirect_to root_path
    end
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to assignments_path, notice:  "The assignment #{@assignment.name} has been deleted."
  end
    
    
  private
    def assignment_params
      params.require(:assignment).permit(:name, :due_date, :course_num, :attachment)
    end
end
