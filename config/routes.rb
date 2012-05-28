Astoryortwo::Application.routes.draw do
  resources :users

  root to: "stories#index", as: :root
  get "user/:id", controller: "users", action: "show", as: :user

  delete "logout" => 'logins#destroy', :as => :logout
  get "logins/new", :as => :new_login
  post "logins/create", :as => :logins
  
  post "invites/new" => "invites#create", as: :invites
  
  get "stories/new", controller: "stories", action: "new", as: :stories
  put "stories/:id", controller: "users", action: "update"
  get "stories/:id", controller: "stories", action: "show", as: :story
  post "stories/:id", controller: "stories", action: "create_story"
  post "stories/:id/submission", controller: "stories", action: "create_submission", as: :submissions
  put "/stories/:id/submission", controller: "stories", action: "update"

end
