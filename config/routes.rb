# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'
  get '/dashboard', to: 'users#show'
  get '/discover', to: 'discover#index'
  get '/movies', to: 'movies#index'
  resources :users, only: %i[create]
  resources :movies, only: %i[show] do
    get '/viewing-party/new', to: 'parties#new' # refactor?
    resources :parties, only: %i[create]
  end
end

