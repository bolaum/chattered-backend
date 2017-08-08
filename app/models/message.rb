# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  sent_at    :datetime         not null
#  nick_id    :integer          not null
#  channel_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
  default_scope -> { order(sent_at: :desc) }
  belongs_to :nick
  belongs_to :channel

  validates_presence_of :content, :sent_at
end
