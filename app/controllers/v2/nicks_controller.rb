module V2
  class NicksController < ApplicationController
    def list
      json_response({ message: 'V2 api demo!'})
    end
  end
end
