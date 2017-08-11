class AuthenticationController < ApplicationController
  # return auth token once nick is authenticated
  def authenticate
    auth_token = AuthenticateNick.new(auth_params[:name]).call
    response = { message: "Logged in", auth_token: auth_token }
    json_response(response, :created)
  end

  private
    def auth_params
      params.permit(:name)
    end
end
