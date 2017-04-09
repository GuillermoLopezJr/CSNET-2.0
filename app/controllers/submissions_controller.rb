class SubmissionsController < ApplicationController
   def index
       
      @submissions = Submission.all
      @is_instructor  = current_instructor
      @is_assistant   = current_assistant
      @is_student     = current_student
       
      if(@is_instructor)
        @courses = @is_instructor.courses
        @courses.each do |course|
            if (@assignments == nil)
                @assignments = course.assignments.all
            else
                @assignments = @assignments + course.assignments.all
            end
        end
       elsif(@is_assistant)
            @courses = @is_assistant.courses
            @courses.each do |course|
                if (@assignments == nil)
                    @assignments = course.assignments.all
                else
                    @assignments = @assignments + course.assignments.all
                end
              end
        else
            @courses = @is_student.courses
            @courses.each do |course|
                if(@assignments == nil)
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
      @assignment = Assignment.find_by(name: params[:submission][:assignment])
      @submission = @student.submissions.create!(name: params[:submission][:name], 
                                            attachment: params[:submission][:attachment],
                                            assignment: @assignment)
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
class SubmissionsController < ApplicationController
   def index
       
      @submissions = Submission.all
      @is_instructor  = current_instructor
      @is_assistant   = current_assistant
      @is_student     = current_student
       
      if(@is_instructor)
        @courses = @is_instructor.courses
        @courses.each do |course|
            if (@assignments == nil)
                @assignments = course.assignments.all
            else
                @assignments = @assignments + course.assignments.all
            end
        end
       elsif(@is_assistant)
            @courses = @is_assistant.courses
            @courses.each do |course|
                if (@assignments == nil)
                    @assignments = course.assignments.all
                else
                    @assignments = @assignments + course.assignments.all
                end
              end
        else
            @courses = @is_student.courses
            @courses.each do |course|
                if(@assignments == nil)
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
      @assignment = Assignment.find_by(name: params[:submission][:assignment])
      @submission = @student.submissions.create!(name: params[:submission][:name], 
                                            attachment: params[:submission][:attachment],
                                            assignment: @assignment)
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
