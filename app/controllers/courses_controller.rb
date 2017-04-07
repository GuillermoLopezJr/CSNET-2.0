class CoursesController < ApplicationController

  def create
    #only instructors can create courses
    @instructor = current_instructor
    @course = @instructor.courses.create(course_params)
    @course.save
    redirect_to @course
  end
  
  def destroy
      @course = Course.find(params[:id])
      @course.destroy
      flash[:notice] = 'The course #{@course.name} #{@course.number} has been deleted.'
      redirect_to courses_path
  end

  def index
    #need to distinguish between student and instructor
    @user = current_instructor
    @isInstructor = true
    if @user == nil
      #a student is signed in
      @user = current_student
      @isStudent = true
      @isInstructor = false
      @courses = @user.courses
    else
      #an instructor is singed in
      @courses = @user.courses
    end
  end

  def show
    @course = Course.find(params[:id])
    if current_instructor != nil
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

