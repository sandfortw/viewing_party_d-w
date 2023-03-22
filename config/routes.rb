# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/register', to: 'users#new'
  resources :users, only: %i[create]
  resources :users, only: %i[show] do
    get '/discover', to: 'discover#index'
    resources :movies, only: %i[index show]
  end
end
