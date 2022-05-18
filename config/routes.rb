Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # login routes
  post '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  resources :users, only: [:create, :show, :index] do 
  resources :items, only: [:create, :show, :index, :destroy]
  end

  # users routes
  get "user/:id", to: "users#show"
  post "user", to: "users#create"
  get "users", to: "users#index"
  get "usersclassrooms", to:"users#UserClassrooms"
  get "usersassignments/:id", to:"users#userAssignment"
  patch "updateuser", to:"users#update"

  # classrooms routes
  get "classrooms", to:"classrooms#showAll"
  post "createclass", to:"classrooms#createClass"
  delete "delete/:id", to:"classrooms#deleteClass"

  # assignments routes
  get "assignments", to:"assignments#showAll"
  post "createassignment", to:"assignments#createAssignment" 
  patch "editassignment/:id", to:"assignments#editAssignment"
  delete "deleteassignment/:id", to:"assignments#deleteAssignment"

  # solution routes
  post "createsolution", to:"solution#createSolution"
  get "usersolutions/:id", to:"users#UserSolution"
  get "allsolutions/:id", to:"solution#showallSolutions"
end
