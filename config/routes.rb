Rails.application.routes.draw do

  get '/s/:name', to: 'home#show'
  post '/new', to: 'home#new'
  post '/search', to: 'home#search'
  root to: 'home#index'

end
