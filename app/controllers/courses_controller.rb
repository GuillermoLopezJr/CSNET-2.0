class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
  end

  def new
    if not instructor_signed_in?
      redirect_to root_path
    end
    @course = Course.new
  end

  def create
    #only instructors can create courses
    if not instructor_signed_in?
      redirect_to root_path
    end
    
    @instructor = current_instructor
    @course = Course.new(course_params)
    
    if @course.new_record?  
       @course = @instructor.courses.create(course_params)
        if @course.save
         flash[:success] = "The course #{@course.name} #{@course.number} has been created successfully"
         redirect_to courses_path
        else
          flash[:danger] = "The Form was filled out incorrectly or course already exist"
          redirect_to courses_path
        end
    end
  end
  
  def destroy
    if not instructor_signed_in?
      redirect_to root_path
    end
    @course = Course.find(params[:id])
    @course.destroy
    flash[:danger] = "The course #{@course.name} #{@course.number} has been deleted."
    redirect_to courses_path
  end

  def index
    #need to distinguish between student and instructor
    @isInstructor = false
    @isStudent = false
    @isAssistant = false
      
    if instructor_signed_in?
      @user = current_instructor
      @isInstructor = true
      
    elsif student_signed_in?
      @user = current_student
      @isStudent = true
      
    elsif assistant_signed_in?
      @user = current_assistant
      @isAssistant = true
      
    else
      redirect_to root_path
    end
    
    @courses = @user.courses
  end


  def show
    @course = Course.find(params[:id])
    if instructor_signed_in?
      @isInstructor = true
    else
      @isInstructor = false
    end
  end

  private
    def course_params
      params.require(:course).permit(:name, :number, :session, :year)
    end
    
end

