Astoryortwo::Application.routes.draw do
  resources :users

  root to: "stories#index", as: :stories

  get "stories/:id", controller: "stories", action: "show", as: :story
  post "stories/:id", controller: "stories", action: "create"
  post "stories/:id/submission", controller: "stories", action: "create", as: :submissions

end
