require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:nicks) { create_list(:nick, 10) }
  let(:nick_id) { nicks.first.id }

  # Test suite for GET /nicks
  describe 'GET /nicks' do
    # make HTTP get request before each example
    before { get '/nicks' }

    it 'returns nicks' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /nicks/:id
  describe 'GET /nicks/:id' do
    before { get "/nicks/#{nick_id}" }

    context 'when the record exists' do
      it 'returns the nick' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(nick_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:nick_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Nick/)
      end
    end
  end
end
