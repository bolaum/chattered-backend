Rails.application.routes.draw do
  post '/login',                  to: 'authentication#authenticate'

  # namespace the controllers without affecting the URI

  # scope module: :v2, constraints: ApiVersion.new('v2') do
  #   get   '/nicks',                 to: 'nicks#list'
  # end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    get   '/nicks',                 to: 'nicks#list'
    # constraint to accept dotted usernames
    get   '/nicks/:id',             to: 'nicks#show', constraints: { id: VALID_ID_ROUTES_REGEXP }
    get   '/channels',              to: 'channels#list'
    post  '/channels',              to: 'channels#create'
    get   '/channels/:id',          to: 'channels#show'
    post  '/channels/:id',          to: 'channels#join'
    get   '/channels/:id/messages', to: 'messages#show'
    post  '/channels/:id/messages', to: 'messages#create'
  end

  root 'application#page_not_found'
  match '*path' => redirect('/'), via: [:get, :post]
end
