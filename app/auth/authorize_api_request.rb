class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid nick object
  def call
    nick
  end

  private
    attr_reader :headers

    def nick
      # check if nick is in the database
      # memoize nick object
      @nick ||= Nick.find(decoded_auth_token[:nick_id]) if decoded_auth_token
      # handle nick not found
      rescue ActiveRecord::RecordNotFound => e
      # raise custom error
      raise ExceptionHandler::InvalidToken
    end

    # decode authentication token
    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    # check for token in `Authorization` header
    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end
      raise ExceptionHandler::MissingToken
    end
end
