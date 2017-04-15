class SubmissionsController < ApplicationController
   def index
      @submissions = Submission.all
      @is_instructor  = current_instructor
      @is_assistant   = current_assistant
      @is_student     = current_student

      @isInstructor  = true
      @isAssistant   = true
      @isStudent     = true
      if(@is_instructor)
        @courses = @is_instructor.courses
        @isAssistant   = false
        @isStudent     = false
      elsif (@is_assistant)
        @courses = @is_assistant.courses
        @isInstructor  = false
        @isStudent     = false
      else
        @courses = @is_student.courses
        @isInstructor  = false
        @isAssistant   = false
      end
    end
   
   def new
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
       
      @student = current_student
      @assignment = Assignment.find_by(name: params[:submission][:assignment])
      
      @submission = @student.submissions.create(name: params[:submission][:name], 
                                            attachment: params[:submission][:attachment],
                                            assignment: @assignment)
      if @submission.save
          flash[:success] = "The assignment #{@submission.name} has been submitted successfully"
          redirect_to submissions_path
      else
          flash[:danger] = "Assignment was not submited successfuly. Please try again"
          redirect_to submissions_path
      end
      
   end
   
   def destroy
      @submission = Submission.find(params[:id])
      @submission.destroy
      redirect_to submissions_path, notice:  "The submission #{@submission.name} has been deleted."
   end
   
   private
      def submission_params
      params.require(:submission).permit(:name, :assignment, :attachment)
   end
end
