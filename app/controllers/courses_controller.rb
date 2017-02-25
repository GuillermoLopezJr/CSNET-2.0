class CoursesController < ApplicationController


  #def create
  #  @instructor = current_instructor
  #  @course = @instructor.courses.create(name: params[:name], number: params[:number])
  #end


  def create
    @instructor = current_instructor
    @course = @instructor.courses.create(course_params)
    redirect_to @course
  end

  def index
    @course = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  private
    def course_params
      params.require(:course).permit(:name, :number)
    end
    
end

