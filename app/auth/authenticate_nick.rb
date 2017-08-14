class AuthenticateNick
  def initialize(ref, request = nil)
    @ref = ref
    @request = request
  end

  # Service entry point
  def call
    nick = get_nick
    # create or renew authentication token
    auth_token = JsonWebToken.encode(nick_id: nick.id) if nick
    return nick, auth_token
  end

  private
    attr_reader :ref
    attr_reader :request

    def get_nick
      unless ref.nil?
        begin
          # try to fetch nick
          nick = Nick.find_by_id_or_name(ref)
        rescue ActiveRecord::RecordNotFound
          # check if name is valid to continue
          raise ExceptionHandler::InvalidNickname unless name_valid?(ref)
        end
        name = nick ? nick.name : ref

        # check if nick exists
        unless nick
          # create if it doesn't
          nick = Nick.create(name: name, token_digest: 'notatoken', status: 'offline')
        end
        # check if nick is available
      else
        # no nick reference was provided
        begin
          # try to extract it from token
          nick = AuthorizeApiRequest.new(request.headers).call
        rescue ExceptionHandler::InvalidToken
          # token is not valid
          raise
        rescue
          # fallback to missing parameter error
          raise ActionController::ParameterMissing.new(:name)
        end
      end

      # check if nick is currently in use
      if nick.status == 'online'
        raise ExceptionHandler::NickInUse
      end

      # set nick in use
      nick.status = 'online'
      nick.save

      return nick
    end

    def name_valid?(name)
      name =~ Regexp.new('^' + VALID_NAME_REGEXP.source + '$')
    end
end
