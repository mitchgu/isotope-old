Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # About pages
  get "/about/" => "about#show", page: "home"
  get "/about/:page" => "about#show"

  # Dashboard
  get '/profile' => "users#show", as: "profile"

  # Managing users
  get '/register' => 'users#new', as: "register"
  post '/users' => 'users#create', as: "register_submit"
  get '/activate/:token' => 'users#activate', as: "activate"
  get '/resend-activation' => 'users#resend_activation', as: "resend_activation"

  # Managing sessions
  get '/login' => 'sessions#new', as: "login"
  post '/login' => 'sessions#create', as: "login_submit"
  get '/logout' => 'sessions#destroy', as: "logout"

  root "about#show", page: "home", as: "home"
end
