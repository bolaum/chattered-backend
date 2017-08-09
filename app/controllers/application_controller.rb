class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def page_not_found
    render plain: 'Nothing to see here.', status: 404
  end
end
