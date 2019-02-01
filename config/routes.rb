Rails.application.routes.draw do
  #setp
  root 'tasks#index'

  #setp 21
  namespace :admin do
    resources :users
  end

  #setp20
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  #setp
  resources :tasks do
    collection do
      get :search
    end
  end

  #setp19
  resources :users,only:[:new,:create,:show]
end
