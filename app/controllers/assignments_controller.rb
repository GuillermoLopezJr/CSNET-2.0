class AssignmentsController < ApplicationController
  def new
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save
    redirect_to @assignment
  end

  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  private
    def assignment_params
      params.require(:assignment).permit(:name, :due_date, :course)
    end
end
