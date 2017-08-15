module V1
  class ChannelsController < ApplicationController
    before_action :set_nick, only: [:create, :join]
    before_action :set_channel, only: [:show, :join]

    def list
      channels = Channel.all
      json_response(channels)
    end

    def show
      json_response(@channel)
      # json_response(@channel, include: joined_nicks_info)
      # json_response(@channel, include: complete_info)
    end

    def create
      channel = @nick.owned_channels.create!(channel_params)
      json_response(channel, :created)
    end

    def join
      unless @nick.joined_channels.exists?(@channel.id)
        @nick.joined_channels << @channel
      end
      json_response(@channel, :accepted)
    end

    private

      def channel_params
        # whitelist params
        params.require(:title) and params.permit(:title)
      end

      def set_nick
        @nick = Nick.find(params[:nick_id])
      end

      def set_channel
        begin
          @channel = Channel.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          raise ExceptionHandler::ChannelNotFound
        end
      end

      def joined_nicks_info
        { joined_nicks: { only: [:id, :name, :status] } }
      end

      def complete_info
        joined_nicks_info.merge(messages: {}, owner: {})
      end
  end
end
