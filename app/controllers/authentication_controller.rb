class AuthenticationController < ApplicationController
  # return auth token once nick is authenticated
  def authenticate
    auth_token = AuthenticateNick.new(auth_params[:name]).call
    json_response(auth_token: auth_token)
  end

  private
    def auth_params
      params.permit(:name)
    end
end
