module V1
  class NicksController < ApplicationController
    def list
      @nicks = Nick.all
      json_response(@nicks)
    end

    def show
      nick = Nick.find_by_id_or_name(params[:id])
      json_response(nick, include: :joined_channels)
    end
  end
end
