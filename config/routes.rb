Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    collection do
      get :status
    end
  end
end
