#not used

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def hello
    render html: "hello, world!"
  end
  
  def index
    render "home/index.html.erb"
  end
  
end
