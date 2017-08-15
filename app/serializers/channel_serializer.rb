class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at
  has_many :messages
  has_many :joined_nicks
  belongs_to :owner
end
