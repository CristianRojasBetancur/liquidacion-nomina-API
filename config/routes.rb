Rails.application.routes.draw do
  resources :workers, only: [:index, :create, :show]
  resources :users
  resources :companies, only: [:index, :create, :show]

  # Auth route
  post '/login', to: "auth#login"
end
