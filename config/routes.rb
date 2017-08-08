Rails.application.routes.draw do
  get '/nicks', to: 'nicks#list'
  get '/nicks/:id', to: 'nicks#show'

  root 'application#page_not_found'
  match '*path' => redirect('/'), via: [:get, :post]
end
