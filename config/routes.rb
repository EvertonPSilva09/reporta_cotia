Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # Define routes for report index
  root to: 'reports#index'

  namespace :admin do
    resources :users, only: [:index, :edit, :update]
  end
  
  resources :reports, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      patch :approve
    end
    collection do
      get :pending
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }
end