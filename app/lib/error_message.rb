class ErrorMessage
  def self.not_found(record = 'record')
    "#{record} not found"
  end

  def self.invalid(name = 'Name')
    "Invalid #{name}"
  end

  def self.nick_in_use
    'Nickname already in use'
  end

  def self.missing_token
    'Missing token'
  end
end
