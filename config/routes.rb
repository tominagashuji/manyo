Rails.application.routes.draw do
  resources :blogs
  root 'tasks#index'
  resources :tasks
end
