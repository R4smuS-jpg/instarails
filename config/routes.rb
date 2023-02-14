Rails.application.routes.draw do
  # root path
  root 'users#index'

  # users
  get '/sign-up', to: 'users#new'
  resources :users, only: %i[index
                             create
                             show
                             edit
                             update
                             destroy]

  # sessions
  get '/sign-in', to: 'sessions#new'
  resources :sessions, only: %i[create destroy]

  # posts
  resources :posts, only: %i[index
                             new
                             create
                             show
                             edit
                             update
                             destroy]

end
