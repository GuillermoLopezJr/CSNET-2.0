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
      puts "submissions url is "
      puts @submission.attachment_url
      puts "end sub"
      
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

    # first find the course that we want to download the submissions for
    @course_chosen = Course.find(params[:submission][:course_id])

    # the assignment we want to get submissions for
    @assignment_chosen = Assignment.find_by(name: params[:submission][:assignment])

    # get all the submissions for that assignment
    @all_submissions = Submission.where(assignment_id: @assignment_chosen.id)
    
    # get all the attachment names for that assignment (b/c we only store the attachmetn on aws)
    # note: escape https://431storage.s3.amazonaws.com/ since not needed
    @desired_attachment_names = @all_submissions.map{ |sub| sub.attachment_url[36..-1] }

    # limit submissions to only new the newest ones
    # TODO

    # configure aws
    Aws.config.update({
      region: 'us-east-1',
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    })
    
    s3 = Aws::S3::Resource.new
    # the bucket where submissions are stored
    bucket = s3.bucket("431storage")
  
    # These are all the files in the bucket - for testing purposes
    #files_in_bucket = bucket.objects(prefix: '').collect(&:key)
    #puts "putting "
    #puts files_in_bucket

    
    # files downloaded first to the tmp folder
    local_folder = "tmp"
   
    # the files to download 
    files = @desired_attachment_names

    # Download the files from S3 to a local folder
    files.each do |file_name|
      # Get the file object
      file_obj = bucket.object("#{file_name}")
      # Save it on disk
      file_obj.get(response_target: "#{local_folder}/#{file_name}")
    end

    # after files have been downloaded zip them all
    zipfile_name = "submissions.zip"

    # Open a zip file
    Zip::File.open("#{local_folder}/#{zipfile_name}", Zip::File::CREATE) do |zipfile|
      files.each do |filename|
         # Add the file to the zip
        zipfile.add(filename, "#{local_folder}/#{filename}")
      end
    end

    # Create the zip file object to download
    zip_obj = bucket.object("#{local_folder}/#{zipfile_name}")

    #download
    send_file "#{local_folder}/#{zipfile_name}"

    # success
  end


  helper_method :download 

   private
    def submission_params
      params.require(:submission).permit(:name, :assignment, :attachment)
    end
end
