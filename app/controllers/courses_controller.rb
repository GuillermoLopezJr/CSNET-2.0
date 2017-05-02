class CoursesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  
  # shows a single course
  def show
    @course = Course.find(params[:id])
  end


  # used for the new course form
  def new
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    @course = Course.new
  end


  # used after submitting a new course form 
  def create
    
    #only instructors can create courses
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    
    @instructor = current_instructor
    
    #Check if that course already exists
    @oldCourse = Course.where(  number: params[:course][:number], year: params[:course][:year], session: params[:course][:session]).first
    @course = Course.new(course_params)
    
    #Im sorry this controll structure is just out of control
    if @course.new_record?  
        if (@oldCourse == nil) 
          @course = @instructor.courses.create(course_params)
          # The course was created
          if  @course.save
            flash[:success] = "The course #{@course.name} #{@course.number} has been created successfully"
            redirect_to courses_path
          # The course was not created
          else 
            flash[:danger] = "Could not create course. Make sure the number is 3 digits."
            redirect_to courses_path
          end
        # The course was a duplicate (not created)
        else
          flash[:danger] = "Could not create course. A course with that number already exists for that semester"
          redirect_to courses_path
        end
    end
  end
  
  
  # Used to delete courses
  def destroy
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    @course = Course.find(params[:id])
    @course.destroy
    flash[:danger] = "The course #{@course.name} #{@course.number} has been deleted."
    redirect_to courses_path
  end


  # used to display all courses
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
      return
    end
    
    @courses = @user.courses.order(sort_column + " " + sort_direction)
  end


  # used to display one course
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
    
   def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "number"
   end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
end

