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
  post '/sign-in', to: 'sessions#create'
  delete '/sign-out', to: 'sessions#destroy'

  # posts
  resources :posts, only: %i[index
                             new
                             create
                             show
                             edit
                             update
                             destroy]

end
