class NicksController < ApplicationController
  def list
    @nicks = Nick.all
    json_response(@nicks)
  end

  def show
    json_response(Nick.find(params[:id]), include: associated_channels)
  end

  private
    def associated_channels
      { owned_channels: { only: :id }, joined_channels: { only: :id } }
    end
end
