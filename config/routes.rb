# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/register', to: 'users#new'
  resources :users, only: %i[create]
  resources :users, only: %i[show] 
  resources :movies, only: %i[index]
    resources :movies, only: %i[show] do
      get '/viewing-party/new', to: 'parties#new' # refactor?
      resources :parties, only: %i[create]
    end
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  get '/dashboard', to: 'users#dashboard'

  get '/discover', to: 'discover#index'
  resources :visitor_movies, only: %i[index show]
end

