require 'rails_helper'

RSpec.describe 'Channels API', type: :request do
  # Initialize the test data
  let!(:nick) { create(:nick) }
  let!(:channels) { create_list(:channel, 20, owner_id: nick.id) }
  let(:nick_id) { nick.id }
  let(:id) { channels.first.id }

  # Test suite for GET /channels
  describe 'GET /channels' do
    # make HTTP get request before each example
    before { get "/channels" }

    it 'returns channels' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /channels/:id
  describe 'GET /channels/:id' do
    before { get "/channels/#{id}" }

    context 'when the record exists' do
      it 'returns the channel' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Channel/)
      end
    end
  end

  # Test suite for POST /channels
  describe 'POST /channels' do
    let(:valid_attributes) { { title: 'VisitNarnia', owner_id: nick_id } }

    context 'when request attributes are valid' do
      before { post "/channels", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      context 'has a blank title' do
        before { post "/channels", params: { title: '   ', owner_id: nick_id } }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Validation failed: Title can't be blank/)
        end
      end

      context 'has no owner' do
        before { post "/channels", params: { title: 'Wasteland' } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Couldn't find Nick/)
        end
      end

      context 'has invalid owner' do
        before { post "/channels", params: { title: 'Wasteland', owner_id: 1000 } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Couldn't find Nick/)
        end
      end
    end
  end
end
