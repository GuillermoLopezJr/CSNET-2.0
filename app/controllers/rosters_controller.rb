require 'spreadsheet'
require 'aws/s3'
class RostersController < ApplicationController
  
  # Used to read a new roster and enroll students accordingly
  def index
      # only an instructor should upload rosters
      if not instructor_signed_in?
        redirect_to root_path
        return
      end
      
      @rosters = Roster.all
      @roster = session[:roster]
      Spreadsheet.client_encoding = 'UTF-8'

      # Establish a connection with AWS
      connection = AWS::S3::new(:aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],       
              :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'])
      
      # Instead of reading the contents of f, pass f (an IO object) to Spreadsheet.open
      book = nil
      open @roster["attachment"]["url"] do |f|
        book = Spreadsheet.open f
      end
      
      @sheet1 = book.worksheet 0
      @instructor = current_instructor
      
      # find course to add student to
      @course =  @instructor.courses.find_by( id: @roster["course_id"])
      
      for i in 1..(@sheet1.row_count-1) do
          
          # student with this email ( if they exist already ) 
          @student = Student.find_by( email: @sheet1.row(i)[2] )
          
          # A new student is being created
          if @student == nil
            #Ensure students arent enrolled twice
            if @course.students.where( id: @student ).empty?
              @fullName = @sheet1.row(i)[0]
              @name = @fullName.split(/\s*,\s*/)
              @firstName = @name[1]
              @lastName = @name[0]

              password_length = 8
              pass = Devise.friendly_token.first(password_length)
              
              @student = @course.students.create!(:first_name => @firstName, :last_name => @lastName, :email => @sheet1.row(i)[2], :password => pass)

              if @student.save
                UserMailer.welcome_email(@student, @student.password).deliver_later
              else
                #could not send email
              end
            end
          
          #The student already exists
          else
              #Ensure students arent enrolled twice
              if @course.students.where( id: @student ).empty? 
                @course.students << @student
              end
          end
      end
      redirect_to students_path
  end
  
  
  # used for new roster form
  def new
    @instructor = current_instructor
    @courses = @instructor.courses
    @roster = Roster.new
  end


  # used after submittint a new roster
  def create
    if not instructor_signed_in?
      redirect_to root_path
      return
    end
    
    # Check if that course exists
    @courses = current_instructor.courses
    @course = @courses.find_by( number: params[:roster][:course_num], year: params[:roster][:course_year], session: params[:roster][:course_session] )

    if (@course == nil) 
      flash[:danger] = "Could not upload roster because the corresponding course was not found."
      redirect_to students_path
      return
      
    else
      @roster = Roster.new(course_num: params[:roster][:course_num], attachment: params[:roster][:attachment], course_id: @course.id)
      
      if @roster.save
        session[:roster] = @roster
        redirect_to rosters_path, notice: "The roster for #{@roster.course_num} has been uploaded."
      else
        render "new"
      end
    end
  end
  
  
  private
    def roster_params
      params.require(:roster).permit(:course_num, :course_year, :course_session, :attachment)
    end
end
