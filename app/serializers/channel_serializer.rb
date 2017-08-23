module ChannelSerializer
  class ChannelShortSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  class ChannelFullSerializer < ActiveModel::Serializer
    attributes :id, :title, :created_at
    # has_many :messages
    has_many :joined_nicks
    belongs_to :owner, class_name: 'Nick'
  end
end
