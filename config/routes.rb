Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :events
  resources :booths
  resources :slots
  resource :session
  
  get '/auth/:provider/callback', to: 'sessions#create'

  root 'booths#index'
end
