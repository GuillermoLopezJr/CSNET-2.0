class CoursesController < ApplicationController

  def create
    #only instructors can create courses
    @instructor = current_instructor
    @course = @instructor.courses.create(course_params)
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
    if @user == nil
      #a student is signed in
      @user = current_student
      @course = Course.where( number: @user.course.number)
    else
      #an instructor is singed in
      @course = Course.all
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

