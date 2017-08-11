class AuthenticateNick
  def initialize(ref)
    @ref = ref
  end

  # Service entry point
  def call
    nick = get_nick
    JsonWebToken.encode(nick_id: nick.id) if nick
  end

  private
    attr_reader :ref

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

        if nick.status == 'online'
          raise ExceptionHandler::NickInUse
        end

        nick.status = 'online'
        nick.save
      else
        raise ActionController::ParameterMissing.new(:name)
      end

      return nick
    end

    def name_valid?(name)
      name =~ Regexp.new('^' + VALID_NAME_REGEXP.source + '$')
    end
end
