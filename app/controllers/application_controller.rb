class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  skip_before_action :authorize_request, only: [:page_not_found]

  attr_reader :current_user

  def page_not_found
    render plain: 'Nothing to see here.', status: 404
  end

  private

    # Check for valid request token and return user
    def authorize_request
      @current_user = AuthorizeApiRequest.new(request.headers).call
    end
end
