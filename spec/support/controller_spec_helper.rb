module ControllerSpecHelper
  # generate tokens from nick id
  def token_generator(nick_id)
    JsonWebToken.encode(nick_id: nick_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(nick_id)
    JsonWebToken.encode({ nick_id: nick_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers
    {
      "Authorization" => token_generator(nick.id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end
