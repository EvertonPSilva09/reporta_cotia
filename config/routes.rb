Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

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
    get :search
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }
end