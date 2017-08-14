class AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  # return auth token once nick is authenticated
  def authenticate
    nick, auth_token = AuthenticateNick.new(auth_params[:name], request).call
    response = { message: "Logged in", nick: nick.name, auth_token: auth_token }
    json_response(response, :created)
  end

  private
    def auth_params
      params.permit(:name)
    end
end
