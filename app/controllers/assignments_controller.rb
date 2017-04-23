class AssignmentsController < ApplicationController
  def new
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    @instructor = current_instructor
    @courses = @instructor.courses
  end


  def create
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    
    @currentTime = params[:assignment][:due_date].to_time#Time.now
    @currentMonth = @currentTime.month
    @currentYear = @currentTime.year
    
    if( @currentMonth >= 1 && @currentMonth <= 5 )
      @session = "SPRING"
    elsif( @currentMonth >= 6 && (@currentMonth < 8 || (@currentMonth == 8 && @currentDay <= 11)) ) 
      @session = "SUMMER"
    else 
      @session = "FALL"
    end 
  
    # Check if that course exists
    @course = current_instructor.courses.where( number: params[:assignment][:course_num], year: @currentYear, session: @session ).first
    if (@course == nil) 
      flash[:danger] = "Could not create #{params[:assignment][:name]} because the course was not found."
      redirect_to assignments_path
      return
    end 
    
    #Check if that assignment name is unique to that course
    @oldAssignment = @course.assignments.find_by( name: params[:assignment][:name])
    if (@oldAssignment != nil)
      flash[:danger] = "Could not create #{params[:assignment][:name]} because an assignment with that name exists for that course already."
      redirect_to assignments_path
      return
    end
    
    
    @assignment = Assignment.new(assignment_params)    
    if @assignment.new_record?  
      # The assignment was created
      @assignment = @course.assignments.create(assignment_params)  
      if @assignment.save
        redirect_to assignments_path, notice: "The assignment #{@assignment.name} has been created."
      
      # The assignment was not created
      else 
        flash[:danger] = "Could not create. The form was filled out incorrectly or assignment already exist"
        redirect_to assignments_path
      end
    # The assignment was not created
    else 
      flash[:danger] = "Could not create. The form was filled out incorrectly or assignment already exist"
      redirect_to assignments_path
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
      return
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
    
    @isInstructor = false
    @isStudent    = false
    @isAssistant  = false
   
    if ( student_signed_in? )
      #a student is signed in
      @user = current_student
      @isStudent    = true
      @submissions = @assignment.submissions.all
      
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
      return
    end
    
    @courses = @user.courses
  
  end

  def edit
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    @instructor = current_instructor
    @courses = @instructor.courses
    @assignment = Assignment.find(params[:id])
  end
  
  def update
    if not instructor_signed_in?
      redirect_to root_path
      return
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
      return
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
