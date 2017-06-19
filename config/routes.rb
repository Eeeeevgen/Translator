Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'translate#index'
  post '/' => 'translate#index'

  resources :users, only: [:new, :create, :show]
  resources :user_sessions, only: [:create, :destroy]

  delete 'sign_out' => 'user_sessions#destroy', as: :sign_out

  get 'sign_in' => 'user_sessions#new', as: :sign_in
  post 'sign_in' => 'user_sessions#create', as: :sign_in_post

  get 'sign_up' => 'users#new', as: :sign_up
  post 'sign_up' => 'users#create', as: :sign_up_post
end
