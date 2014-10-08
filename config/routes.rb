Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/moves', to: 'moves#index', as: 'moves'
  get '/moves/show', to: 'moves#show', as: 'moves_data'
  root to: "moves#index"
end
