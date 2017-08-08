class Channel < ApplicationRecord
  has_many :messages
  has_many :channelJoins
  has_many :joined_nicks, through: :channelJoins
  belongs_to :owner, class_name: 'Nick', foreign_key: 'owner_id'
end
