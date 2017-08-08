Rails.application.routes.draw do
  # routes for api versions
  namespace :api do
    [:v1].each do |api_version|
      namespace api_version do
      end
    end
  end

  root 'application#page_not_found'
  match '*path' => redirect('/'), via: [:get, :post]
end
