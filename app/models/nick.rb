# == Schema Information
#
# Table name: nicks
#
#  id           :integer          not null, primary key
#  name         :string           not null
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
    format: { with: VALID_NAME_REGEXP}, uniqueness: { case_sensitive: false }

  # get entry by id or name
  def self.find_by_id_or_name(ref)
    self.where(['id = :ref or name = :ref', { ref: ref.downcase }]).first!
  end

  private
    # Converts name to all lower-case.
    def downcase_name
      name.downcase!
    end
end
