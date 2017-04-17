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
       end
      @student = current_student
      @assignment = Assignment.find_by(name: params[:submission][:assignment])
      @submission = @student.submissions.create!(name: params[:submission][:name], 
                                            attachment: params[:submission][:attachment],
                                            assignment: @assignment)
      if @submission.save
         redirect_to root_path, notice: "The submission #{@submission.name} has been uploaded."
      else
         redirect_to root_path, danger: "Could not upload submission #{params[:submission][:name]}."
      end
   end
   
   def destroy
       if not student_signed_in?
           redirect_to root_path
       end
      @submission = Submission.find(params[:id])
      
      # make sure student who made submission is one destroying it
      if not (@submission.student == current_student)
          redirect_to root_path
      end
      
      @submission.destroy
      redirect_to submissions_path, notice:  "The submission #{@submission.name} has been deleted."
   end
   
   private
    def submission_params
      params.require(:submission).permit(:name, :assignment, :attachment)
    end
end
