class AuthenticateNick
  def initialize(ref)
    @ref = ref
  end

  # Service entry point
  def call
    JsonWebToken.encode(nick_id: nick.id) if nick
  end

  private
    attr_reader :ref

    # verify nick credentials
    def nick
      nick = Nick.find_by_id_or_name(ref)
      return nick if nick && nick.status == 'offline'
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::Forbidden, ErrorMessage.nick_in_use)
    end
end
