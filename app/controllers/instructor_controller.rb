class InstructorController < ApplicationController
  def new
  end

  def create
  end
  
      
  def index
    if instructor_signed_in?
      #render html: 'you are signed in'
    else  
      redirect_to sign_in_path
    end
  end
  
end
