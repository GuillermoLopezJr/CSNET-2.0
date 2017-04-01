class AssistantController < ApplicationController
    
  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end
  
  def index
    redirect_to root_path
  end
  
  def show
    if assistant_signed_in?
      @assistant = current_assistant
      @courses = @assistant.courses
    else  
      redirect_to root_path
    end
  end
end
