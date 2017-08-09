class ChannelsController < ApplicationController
  before_action :set_nick, only: [:create, :join]
  before_action :set_channel, only: [:show, :join]

  def list
    channels = Channel.all
    json_response(channels)
  end

  def show
    json_response(@channel, include: joined_nicks_info)
  end

  def create
    channel = @nick.owned_channels.create!(channel_params)
    json_response(channel, :created)
  end

  def join
    unless @nick.joined_channels.exists?(@channel.id)
      @nick.joined_channels << @channel
    end
    json_response(@channel, :accepted, include: joined_nicks_info)
  end

  private
    def channel_params
      # whitelist params
      params.permit(:title)
    end

    def set_nick
      @nick = Nick.find(params[:nick_id])
    end

    def set_channel
      @channel = Channel.find(params[:id])
    end

    def joined_nicks_info
      { joined_nicks: { only: [:id, :name, :status] } }
    end
end
