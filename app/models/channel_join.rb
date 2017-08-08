class ChannelJoin < ApplicationRecord
  belongs_to :nick
  belongs_to :channel
end
