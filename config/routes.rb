Rails.application.routes.draw do


  get 'course/new'

  get 'course/create'

  get 'instructor/new'
  get 'instructor/create'


  resources :assignments
  get 'assignments/new'

  devise_for :instructors

  devise_scope :instructor do
    authenticated :instructor do
      root 'instructor#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'instructor#index'
  
  resources :courses
  get 'courses/new'
  
end
