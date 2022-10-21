Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  resources :modifications
  resources :periods, only: [:index, :create, :show]
  resources :payrolls
  resources :workers, only: [:index, :create, :show]
  resources :users
  resources :companies, only: [:index, :create, :show]

  # Auth route
  post '/login', to: "auth#login"
end
