class ApplicationController < ActionController::API
  def page_not_found
    render plain: 'Nothing to see here.', status: 404
  end
end
