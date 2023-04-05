# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: :create
  get '/register', to: 'users#new'
  get '/dashboard', to: 'users#show'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  resources :movies, only: %i[index show] do
    get '/viewing-party/new', to: 'parties#new' # refactor?
    resources :parties, only: %i[create]
  end

  get '/discover', to: 'discover#index'
end
