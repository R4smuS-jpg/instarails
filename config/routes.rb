Rails.application.routes.draw do
  # root path
  root 'users#index'
  
  # users
  resources :users

  # sessions
  resources :sessions, only: %i[new create destroy]
end
