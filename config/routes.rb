Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # About pages
  get "/about/" => "about#show", page: "home"
  get "/about/:page" => "about#show"

  # Profile
  get '/profile' => "users#show"

  # Creating users
  get '/register' => 'users#new'
  post '/users' => 'users#create'

  # Managing sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  root "about#show", page: "home"
end
