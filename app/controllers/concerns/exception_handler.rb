module ExceptionHandler
  extend ActiveSupport::Concern

  class AppError < StandardError
    attr_accessor :code
    def initialize(msg, code)
      super(msg)
      @code = code
    end
  end

  def self.define_exception(name, msg, code)
    ExceptionHandler.module_eval %Q?
      class #{name} < AppError
        def initialize()
          super("#{msg}", :#{code})
        end
      end
    ?
  end

  # Define custom error subclasses - rescue catches `StandardErrors`
  self.define_exception('NickInUse', ErrorMessage.nick_in_use, :forbidden)
  self.define_exception('InvalidNickname', ErrorMessage.invalid('nickname'), :unprocessable_entity)

  self.define_exception('MissingToken', ErrorMessage.missing_token, :unprocessable_entity)
  self.define_exception('InvalidToken', ErrorMessage.invalid('token'), :unprocessable_entity)


  included do
    # Define custom handlers
    rescue_from ActionController::ParameterMissing do |e|
      exception_response(AppError.new(ErrorMessage.not_found("Parameter '#{e.param}'"), :unprocessable_entity))
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      exception_response(AppError.new(ErrorMessage.not_found("#{e.model}"), :not_found))
    end

    rescue_from AppError, with: :exception_response
  end

  private
    def exception_response(e)
      json_response({ message: e.message }, e.code)
    end
end
