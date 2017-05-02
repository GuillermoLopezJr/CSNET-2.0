class AssistantController < ApplicationController
  
  # used for the new assistant form
  def new
    if not instructor_signed_in?
      redirect_to root_path
      return
    end

    @instructor = current_instructor
    @courses = @instructor.courses
  end


  # used after submitting a new assistant form
  def create
    if not instructor_signed_in?
      redirect_to root_path
      return
    else
      
      if !(EmailValidator.valid?(params[:assistant][:email]))
        flash[:danger] = "Invalid Email Address."
        redirect_to assistant_index_path
        return
      end
      @instructor = current_instructor
      @course =  @instructor.courses.find_by( number: params[:assistant][:course_num] )
      @assistant = Assistant.find_by( email: params[:assistant][:email] )

      
      # Should never happen
      if @course == nil
        # add instructor failed
        redirect_to root_path, error: "Teaching assistant has been added for #{@course.name} #{@course.number} already exists"
      end
      
      # A new assistant is being created
      if @assistant == nil
        #Ensure assistants arent enrolled twice
        if @course.assistants.where( id: @assistant ).empty? 
          @assistant = @course.assistants.create!(assistant_params)

          if @assistant.save
             UserMailer.welcome_email(@assistant, @assistant.password).deliver_later
          else
            #could not send email
          end
        end
      #The assistant already exists
      else
        #Ensure assistant isnt enrolled twice
        if @course.assistants.where( id: @assistant ).empty? 
          @course.assistants << @assistant
        end
      end
      flash[:success] = "Teaching assistant #{@assistant.first_name} has been added for #{@course.name} #{@course.number}"
      redirect_to assistant_index_path
    end
  end
  
  
  # shows all assistances for an instructos courses
  def index
    if instructor_signed_in?
      @submissions = Submission.all
      @instructor = current_instructor
      @courses = @instructor.courses
      @courses.each do |course|
        if (@assistants == nil)
          @assistants = course.assistants.all
        else
          @assistants = @assistants + course.assistants.all
        end
      end
    else
      redirect_to root_path
      return
    end
  end
  
  
  # shows a single assistant
  def show
    if assistant_signed_in?
      @assistant = current_assistant
      @courses = @assistant.courses
      @isAssistant = true
    else  
      redirect_to root_path
      return
    end
  end
  
  
  private
    def assistant_params
      #change password to something random initally
      password_length = 6
      pass = Devise.friendly_token.first(password_length)
      #puts "pass is "
      #puts pass
      params.require(:assistant).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(:password => pass, :password_confirmation => pass)
    end
end
