module V1
  class MessagesController < ApplicationController
    before_action :set_channel
    before_action :set_nick, only: [:create]

    def show
      json_response(@channel.messages.all)
    end

    def create
      unless @nick.joined_channels.exists?(@channel.id)
        json_response({ message: 'User must join channel before posting.' }, :forbidden)
      else
        @message = @channel.messages.create!(message_params)
        json_response(@channel, :created)
      end
    end

    private
      def message_params
        # whitelist params
        params.permit(:content, :sent_at).merge!(nick: @nick)
      end

      def set_channel
        @channel = Channel.find(params[:id])
      end

      def set_nick
        @nick = Nick.find(params[:nick_id])
      end
  end
end
