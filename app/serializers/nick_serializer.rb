class NickSerializer < ActiveModel::Serializer
  attributes :id, :name, :status
  has_many :joined_channels, serializer: ChannelSerializer::ChannelShortSerializer
end
