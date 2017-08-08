Rails.application.routes.draw do
  get '/nicks', to: 'nicks#list'
  get '/nicks/:id', to: 'nicks#show'
  get '/channels', to: 'channels#list'
  post '/channels', to: 'channels#create'
  get '/channels/:id', to: 'channels#show'
  get '/channels/:id/messages', to: 'messages#show'
  post '/channels/:id/messages', to: 'messages#create'

  root 'application#page_not_found'
  match '*path' => redirect('/'), via: [:get, :post]
end
