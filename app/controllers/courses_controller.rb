class CoursesController < ApplicationController

  def create
    #only instructors can create courses
    @instructor = current_instructor
    @course = @instructor.courses.create(course_params)
    redirect_to @course
  end

  def index
    #need to distinguish between student and instructor
    @user = current_instructor
    if @user == nil
      #a student is signed in
      @user = current_student
      @courses = @user.courses
    else
      #an instructor is singed in
      @courses = @user.courses
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  private
    def course_params
      params.require(:course).permit(:name, :number)
    end
    
end

