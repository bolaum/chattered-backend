class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :sent_at
  belongs_to :nick
  belongs_to :channel
end
