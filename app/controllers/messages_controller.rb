class MessagesController < ApplicationController
  before_action :set_channel
  before_action :set_nick, only: [:create]

  def show
    json_response(@channel.messages.all)
  end

  def create
    @message = @channel.messages.create!(message_params)
    json_response(@channel, :created)
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
