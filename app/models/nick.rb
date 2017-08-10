# == Schema Information
#
# Table name: nicks
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  token_digest :string           not null
#  status       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Nick < ApplicationRecord
  has_many :messages
  has_many :owned_channels, class_name: 'Channel', foreign_key: 'owner_id'
  has_many :channelJoins
  has_many :joined_channels, through: :channelJoins, source: :channel

  attr_accessor :token

  before_save :downcase_name

  validates :name, presence: true, length: { maximum: 50 },
    format: { with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # get entry by id or name
  def self.find_by_id_or_name(ref)
    self.where(['id = :ref or name = :ref', { ref: ref.downcase }]).first!
  end

  # Store nick token digest in the database for use in persistent sessions.
  def remember
    self.token = Nick.new_token
    update_attribute(:token_digest, Nick.digest(token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(token)
    BCrypt::Password.new(token_digest).is_password?(token)
  end

  private
    # Converts name to all lower-case.
    def downcase_name
      name.downcase!
    end
end
