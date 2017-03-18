class AssignmentsController < ApplicationController
  def new
    @instructor = current_instructor
    @courses = @instructor.courses#where( instructor_id: @instructor)
  end

  def create
    @course = current_instructor.courses.find_by number: (params[:assignment][:course_num].to_i)
      
    if (@course != nil)
      @assignment = @course.assignments.create(assignment_params)
      redirect_to @assignment
    else
      redirect_to assignments_path
    end
  end
  
  def delete
    if (@course != nil)
      @assignment = @course.assignments.delete(assignment_params)
      redirect_to assignments_path
    else
      redirect_to assignments_path
    end
  end
  
  def index
    #need to distinguish between student and instructor
    @user = current_instructor
    @isInstructor = true
    
    if (@user == nil)
      #a student is signed in
      @user = current_student
      @courses = @user.courses
      @courses.each do |course|
        if (@assignments == nil)
          @assignments = course.assignments.all
        else
          @assignments = @assignments + course.assignments.all
        end
      end
      #@assignments = @user.courses.assignments #Assignment.where(course_id: @user.course_id)
      @isInstructor = false
    else
      #an instructor is singed in
      @courses = @user.courses
      @courses.each do |course|
        if (@assignments == nil)
          @assignments = course.assignments.all
        else
          @assignments = @assignments + course.assignments.all
        end
      end
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
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
      params.require(:assignment).permit(:name, :due_date, :course_num,:attachment)
    end
end
