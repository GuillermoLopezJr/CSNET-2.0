class AssistantController < ApplicationController
    
  def new
    if instructor_signed_in?
      @instructor = current_instructor
      @courses = @instructor.courses
    else 
      redirect_to root_path
    end
  end

  def create
    if not instructor_signed_in?
      redirect_to root_path
    else 
      @instructor = current_instructor
      @course =  @instructor.courses.find_by( number: params[:assistant][:course_num] )
      @assistant = Assistant.find_by( email: params[:assistant][:email] )
      
      # Should never happen
      if @course == nil
        # add instructor failed
        redirect_to root
      end
      
      # A new assistant is being created
      if @assistant == nil
        #Ensure assistants arent enrolled twice
        if @course.assistants.where( id: @assistant ).empty? 
          @assistant = @course.assistants.create!(assistant_params)
          @assistant.save
        end
      #The assistant already exists
      else
        #Ensure assistant isnt enrolled twice
        if @course.assistants.where( id: @assistant ).empty? 
          @course.assistants << @assistant
        end
      end
      redirect_to root_path
    end
  end
  
  def index
    redirect_to root_path
  end
  
  def show
    if assistant_signed_in?
      @assistant = current_assistant
      @courses = @assistant.courses
    else  
      redirect_to root_path
    end
  end
  
  private
    def assistant_params
      #change password to something random initally
      password_length = 6
      pass = Devise.friendly_token.first(password_length)
      #puts "pass is "
      pass = "password"
      #puts pass
      params.require(:assistant).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(:password => pass, :password_confirmation => pass)
    end
end
