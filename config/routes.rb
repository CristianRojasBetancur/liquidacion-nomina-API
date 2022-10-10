Rails.application.routes.draw do
  resources :workers
  resources :companies
  resources :users
  resources :companies, only: [:index, :create, :show, :destory]

  # Auth route
  post '/login', to: "auth#login"
end
