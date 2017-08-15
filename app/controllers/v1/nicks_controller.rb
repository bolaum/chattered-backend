module V1
  class NicksController < ApplicationController
    def list
      @nicks = Nick.all
      json_response(@nicks)
    end

    def show
      nick = Nick.find_by_id_or_name(params[:id])
      json_response(nick)
    end

    private

      def associated_channels
        { owned_channels: { only: :id }, joined_channels: { only: :id } }
      end
  end
end
