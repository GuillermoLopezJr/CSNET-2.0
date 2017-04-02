Rails.application.routes.draw do

  get 'submissions/index'

  get 'submissions/new'

  get 'submissions/create'

  get 'submissions/destroy'

  get 'rosters/index'

  get 'rosters/new'

  get 'rosters/create'

  get 'course/new'
  get 'course/create'
  get 'instructor/new'
  get 'instructor/create'

  resources :assignments
  get 'assignments/new'

  resources :courses
  get 'courses/new'
  
  get 'instructor/enrollStudent'
  post 'instructor/addEnrolledStudent', to: 'instructor#addEnrolledStudent'
  
  resources :instructor
  get 'instructor/new'
  get 'instructor/index'
  
  resources :assistant
  get 'assistant/new'
  #get 'instructor/enrollStudent', to: 'instructor#enrollStudent'

  
  resources :students
  get 'students/new'
  
  resources :rosters
  get 'courses/new'
  get 'rosters/new'
  get 'rosters/index'
  
  resources :submissions
  get 'submissions/new'
  
  devise_for :student
  devise_scope :student do
    authenticated :student do
      root 'students#show', as: :authenticated_students_root
    end
    
    authenticated :instructor do
      root 'instructor#show', as: :authenticated_instructor_root
    end
    
    authenticated :assistant do
      root 'assistant#show', as: :authenticated_assistant_root
    end
    
    unauthenticated do
      root 'application#index'
    end
  end
  
  devise_for :instructors
  devise_scope :instructor do
    
    unauthenticated do
      root 'application#index'
    end
  end
  
  devise_for :assistants
  devise_scope :assistant do
    
    unauthenticated do
      root 'application#index'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#index'
  

  
end
