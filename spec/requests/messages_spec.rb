require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  # Initialize the test data
  let!(:nick) { create(:nick) }
  let(:nick_id) { nick.id }
  let!(:channel) { create(:channel, owner_id: nick_id) }
  let(:channel_id) { channel.id }
  let!(:messages) { create_list(:message, 50, nick_id: nick_id, channel_id: channel_id) }

  # Test suite for GET /channel/:channel_id/messages
  describe 'GET /channels/:channel_id/messages' do
    # make HTTP get request before each example
    before { get "/channels/#{channel_id}/messages" }

    it 'returns messages for channel' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(50)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for post /channel/:channel_id/messages
  describe 'POST /channels/:channel_id/messages' do
    let(:valid_attributes) { {
      content: 'This is not a message.',
      sent_at: 0.seconds.ago,
      nick_id: nick_id
    } }

    context 'when request attributes are valid' do
      context 'and user did not join channel' do
        before { post "/channels/#{channel_id}/messages", params: valid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end

        it 'should not add message to channel' do
          get "/channels/#{channel_id}/messages"
          expect(json.size).to eq(50)
        end
      end

      context 'and user joined channel' do
        before {
          # join channel
          post "/channels/#{channel_id}",  params: { nick_id: nick_id }
          post "/channels/#{channel_id}/messages", params: valid_attributes
        }
        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'should add one message to channel' do
          get "/channels/#{channel_id}/messages"
          expect(json.size).to eq(51)
        end
      end
    end

    # TODO: test invalid attributes
  end
end
