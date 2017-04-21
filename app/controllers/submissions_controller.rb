require 'rubygems'
require 'zip'
require 'aws-sdk' # not 'aws-sdk'
class SubmissionsController < ApplicationController
   
    def index
      @isInstructor  = false
      @isAssistant   = false
      @isStudent     = false
      if(instructor_signed_in?)
        @courses = current_instructor.courses
        @isInstructor = true
      elsif (assistant_signed_in?)
        @courses = current_assistant.courses
        @isAssistant = true
      elsif (student_signed_in?)
        @courses = current_student.courses
        @isStudent = true
      else 
        redirect_to root_path
        return
      end
      
        @courses.each do |course|
          if (@assignments == nil)
            @assignments = course.assignments.all
          else
            @assignments = @assignments + course.assignments.all
          end
        end
      
        @assignments.each do |assignment|
          if (@submissions == nil)
            @submissions = assignment.submissions.all
          else
            @submissions = @submissions + assignment.submissions.all
          end
        end
        
        if student_signed_in?
            @submissions = Submission.where( student_id: current_student )
        end
    end

   
   def new
       if not student_signed_in?
          redirect_to root_path
          return
       end
      @student = current_student
      @isInstructor  = false
      @isAssistant   = false
      @isStudent     = true

      @submission = Submission.new
      @courses = @student.courses
      @assignments = nil
      @courses.each do |course|
        if (@assignments == nil)
          @assignments = course.assignments.all
        else
          @assignments = @assignments + course.assignments.all
        end
      end
   end
   
   
 def create
  if not student_signed_in?
     redirect_to root_path
     return
  end
  
  @student = current_student
  
  @currentTime = Time.now
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
  @course = current_student.courses.where( number: params[:submission][:course_num], year: @currentYear.to_s, session: @session ).first
  if (@course == nil) 
    flash[:danger] = "Could not submit because the corresponding course was not found."
    redirect_to root_path
    return
  end 
  
  @assignment = @course.assignments.find_by(name: params[:submission][:assignment])
  if (@assignment == nil) 
    flash[:danger] = "Could not submit because the corresponding assignment was not found."
    redirect_to root_path
    return
  end 
  
  @submission = @student.submissions.create(name: params[:submission][:name], 
                                        attachment: params[:submission][:attachment],
                                        assignment: @assignment)
  if @submission.save
      flash[:success] = "The assignment #{@submission.name} has been submitted successfully"
      
      # send an acknowldegment email that the submission was turned in successfully
      UserMailer.ack_submission(@student, @submission, @course, @assignment).deliver_later
      redirect_to submissions_path
  else
      flash[:danger] = "Assignment was not submited successfuly. Please try again"
      redirect_to submissions_path
  end
 end
 
   
   def destroy
       if not student_signed_in?
           redirect_to root_path
           return
       end
      @submission = Submission.find(params[:id])
      
      # make sure student who made submission is one destroying it
      if not (@submission.student == current_student)
          redirect_to root_path
          return
      end
      
      @submission.destroy
      redirect_to submissions_path, notice:  "The submission #{@submission.name} has been deleted."
   end
  
  def download
    puts "downloading!!!!!!!!!!!!!!!!!!!!"

    # Configure aws
    Aws.config.update({
      region: 'eu-west-1',
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    })
    
    s3 = Aws::S3::Resource.new

#S3: The bucket you are attempting to access must be addressed using the specified endpoint. #2151
#The S3 link generated for the images is incorrect. It needs to use a different endpoint format.
#the file is probably not in the right locatin

    bucket = s3.bucket("431storage")
    #puts @submission.attachment_url

    #files = ["photo1.png", "photo2.png", "photo3.png", "photo4.png"]
    files = ["Test.pdf"]

    #folder = "uploads/images"

    # Download the files from S3 to a local folder
    files.each do |file_name|
      # Get the file object
      #file_obj = bucket.object("#{folder}/#{file_name}")
      file_obj = bucket.object("/#{file_name}")
      # Save it on disk
      file_obj.get(response_target: "tmp_dir/#{file_name}")
    end

   @submission 
  end
 
  helper_method :download 
   private
    def submission_params
      params.require(:submission).permit(:name, :assignment, :attachment)
    end
end
