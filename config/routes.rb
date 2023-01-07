Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resource :accounts, only: [:edit, :update]
  end

  resources :search, only: [:index]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :relationships, only: [:create]
end