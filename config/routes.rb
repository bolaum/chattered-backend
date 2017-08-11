Rails.application.routes.draw do
  post '/login',                  to: 'authentication#authenticate'
  get   '/nicks',                 to: 'nicks#list'
  # constraint to accept dotted usernames
  get   '/nicks/:id',             to: 'nicks#show', constraints: { id: VALID_ID_ROUTES_REGEXP }
  get   '/channels',              to: 'channels#list'
  post  '/channels',              to: 'channels#create'
  get   '/channels/:id',          to: 'channels#show'
  post  '/channels/:id',          to: 'channels#join'
  get   '/channels/:id/messages', to: 'messages#show'
  post  '/channels/:id/messages', to: 'messages#create'

  root 'application#page_not_found'
  match '*path' => redirect('/'), via: [:get, :post]
end
