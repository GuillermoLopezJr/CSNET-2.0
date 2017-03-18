class RostersController < ApplicationController
  def index
      @rosters = Roster.all
  end
  
    def new
      @instructor = current_instructor
      @courses = @instructor.courses
      @roster = Roster.new
    end
  
    def create
      @roster = Roster.new(roster_params)
  
      if @roster.save
        redirect_to rosters_path, notice: "The roster #{@roster.course_num} has been uploaded."
      else
        render "new"
      end
    end
    
    def import
      require 'spreadsheet'
      Spreadsheet.client_encoding = 'UTF-8'
      @roster = Roster.new(roster_params)
      #book = Spreadsheet.open(@roster.attachment.file.filename)
      #sheet1 = book.worksheet 0
      #sheet1.each do |row|
      #  puts row[0]
      #  exit
    end
  
  private
    def roster_params
      params.fetch(:roster, {}).permit(:course_num, :attachment)
    end
end
