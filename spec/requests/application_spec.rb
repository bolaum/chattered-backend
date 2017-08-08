require 'rails_helper'

RSpec.describe 'Application API', type: :request do
  # Test suite for GET /
  describe 'GET /' do
    # make HTTP get request before each example
    before { get '/' }

    it 'returns invalid path' do
      # Note `json` is a custom helper to parse JSON responses
      expect(response.body).to match(/Nothing to see here/)
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
  end

  # Test suite for GET /notapi
  describe 'GET /notapi' do
    before { get '/notapi' }
    it 'redirects to root' do
      should redirect_to(root_path)
    end
  end
end
