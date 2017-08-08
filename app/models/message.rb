# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  sent_at    :datetime         not null
#  nick_id    :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
  default_scope -> { order(sent_at: :desc) }
  belongs_to :nick
  belongs_to :channel
end
