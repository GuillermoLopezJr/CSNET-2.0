class SubmissionsController < ApplicationController
   def index
      @submissions = Submission.all
      @user = current_instructor
      @isInstructor = true
    
      if (@user == nil)
        #a student is signed in
        @user = current_student
        @courses = @user.courses
        @courses.each do |course|
          if (@assignments == nil)
            @assignments = course.assignments.all
          else
            @assignments = @assignments + course.assignments.all
          end
      end
      #@assignments = @user.courses.assignments #Assignment.where(course_id: @user.course_id)
      @isInstructor = false
      else
        #an instructor is singed in
        @courses = @user.courses
        @courses.each do |course|
          if (@assignments == nil)
            @assignments = course.assignments.all
          else
            @assignments = @assignments + course.assignments.all
          end
        end
      end
   end
   
   def new
      @student = current_student
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
      @submission = @student.submissions.create!(submission_params)
      
      if @submission.save
         redirect_to submissions_path, notice: "The submission #{@submission.name} has been uploaded."
      else
         render "index"
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
