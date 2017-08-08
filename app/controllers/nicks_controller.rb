class NicksController < ApplicationController
  def list
    @nicks = Nick.all
    json_response(@nicks)
  end

  def show
    json_response(Nick.find(params[:id]))
  end
end
