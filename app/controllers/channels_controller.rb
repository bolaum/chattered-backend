class ChannelsController < ApplicationController
  before_action :set_owner, only: [:create]

  def list
    @channels = Channel.all
    json_response(@channels)
  end

  def show
    json_response(Channel.find(params[:id]))
  end

  def create
    @channel = @owner.owned_channels.create!(channel_params)
    json_response(@channel, :created)
  end

  private
    def channel_params
      # whitelist params
      params.permit(:title)
    end

    def set_owner
      @owner = Nick.find(params[:owner_id])
    end
end
