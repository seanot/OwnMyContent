require 'sidekiq/web'

OwnMyContent::Application.routes.draw do

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/select"
  root 'users#index'
  resources :feeds

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  # get "/logout" => "sessions#destroy"
  delete "/logout" => "sessions#destroy"
  get '/logout', to: 'sessions#destroy'
  ####for db oauth:
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  mount Sidekiq::Web, at: '/sidekiq'
end
