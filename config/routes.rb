Railscasts::Application.routes.draw do
  root :to => "episodes#index"

  match "auth/:provider/callback" => "users#create"
  match "about" => "info#about", :as => "about"
  match "give_back" => "info#give_back", :as => "give_back"
  match "login" => "users#login", :as => "login"
  match "logout" => "users#logout", :as => "logout"
  match "feedback" => "feedback_messages#new", :as => "feedback"

  resources :users
  resources :comments
  resources :episodes
  resources :feedback_messages
end
