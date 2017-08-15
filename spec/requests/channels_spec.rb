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
    before { get "/channels", headers: valid_headers }

    it 'returns channels' do
      expect(jsonapi).not_to be_empty
      expect(jsonapi.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /channels/:id
  describe 'GET /channels/:id' do
    before { get "/channels/#{id}", headers: valid_headers }

    context 'when the record exists' do
      it 'returns the channel' do
        expect(jsonapi).not_to be_empty
        expect(jsonapi['id']).to eq(id.to_s)
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
        expect(response.body).to match(/Channel not found/)
      end
    end
  end

  # Test suite for POST /channels
  describe 'POST /channels' do
    let(:valid_attributes) { { title: 'VisitNarnia', nick_id: nick_id } }
    before { post "/channels", params: params.to_json, headers: valid_headers }

    context 'when request attributes are valid' do
      let(:params) { valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'should create one channel' do
        get "/channels", headers: valid_headers
        expect(jsonapi.size).to eq(21)
      end
    end

    context 'when an invalid request' do
      context 'has a blank title' do
        let(:params) { { title: '   ', nick_id: nick_id } }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Parameter 'title' not found/)
        end
      end

      context 'has no owner' do
        let(:params) { { title: 'Wasteland' } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Nick not found/)
        end
      end

      context 'has invalid owner' do
        let(:params) { { title: 'Wasteland', nick_id: 1000 } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Nick not found/)
        end
      end
    end
  end

  # Test suite for POST /channels/:id
  describe 'POST /channels/:id' do
    let(:params) { { nick_id: nick_id } }
    before { post "/channels/#{id}", params: params.to_json, headers: valid_headers }

    it 'returns status code 202' do
      expect(response).to have_http_status(202)
    end

    it 'should join the channel' do
      get "/nicks/#{nick_id}", headers: valid_headers
      expect(response).to have_http_status(200)
      expect(jsonapi['joined_channel_ids'].size).to eq(1)
    end
  end
end
