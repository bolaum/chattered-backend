class Message < ApplicationRecord
  default_scope -> { order(sent_at: :desc) }
  belongs_to :nick
  belongs_to :channel
end
