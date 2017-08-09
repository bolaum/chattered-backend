# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Channel < ApplicationRecord
  has_many :messages
  has_many :channelJoins
  has_many :joined_nicks, through: :channelJoins, source: :nick
  belongs_to :owner, class_name: 'Nick', foreign_key: 'owner_id'

  validates_presence_of :title
end
