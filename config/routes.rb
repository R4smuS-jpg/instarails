Rails.application.routes.draw do
  # root path
  root 'posts#index'

  # users
  get '/sign-up', to: 'users#new'
  post '/sign-up', to: 'users#create'

  get '/edit-account', to: 'users#edit'
  patch '/edit-account', to: 'users#update'

  delete '/delete-avatar', to: 'users#delete_avatar'
  delete '/delete-account', to: 'users#destroy'
  resources :users, only: %i[index show]

  # sessions
  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'
  delete '/sign-out', to: 'sessions#destroy'

  # posts
  get '/create-post', to: 'posts#new'
  post '/create-post', to: 'posts#create'

  resources :posts, only: %i[index
                             show
                             edit
                             update
                             destroy] do
    # comments
    resources :comments, only: %i[edit create update destroy]
  end

  # followings
  post '/follow/:id', to: 'followings#create', as: 'follow_user'
  delete '/unfollow/:id', to: 'followings#destroy', as: 'unfollow_user'
end
