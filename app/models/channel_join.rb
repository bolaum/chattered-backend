# == Schema Information
#
# Table name: channel_joins
#
#  id         :integer          not null, primary key
#  nick_id    :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChannelJoin < ApplicationRecord
  belongs_to :nick
  belongs_to :channel
end
