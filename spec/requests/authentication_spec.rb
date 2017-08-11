require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  # Authentication test suite
  describe 'POST /login' do
    # create test nicks
    let(:online_nick) { create(:nick, status: 'online') }
    let(:offline_nick) { create(:nick, status: 'offline') }
    # set request.headers to our custom headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    context 'when new user logs in' do
      # let(:headers) { {} }

      context 'with a valid nickname' do
        context 'that is new' do
          before { post '/login', params: { name: 'roland1337'} }

          it 'returns an authentication token and creates nick' do
            expect(response).to have_http_status(201)
            expect(json['auth_token']).not_to be_nil
            expect(Nick.all.count).to eq(1)
          end
        end

        context 'that is offline (available)' do
          before { post '/login', params: { name: offline_nick.name} }

          it 'returns an authentication token and sets user online' do
            expect(json['auth_token']).not_to be_nil
            get "/nicks/#{offline_nick.name}"
            expect(json['status']).to eq('online')
          end
        end

        context 'that is online (unavailable)' do
          before { post '/login', params: { name: online_nick.name} }

          it 'returns a forbidden error' do
            expect(response).to have_http_status(403)
            expect(response.body).to match(/Nickname already in use/)
          end
        end
      end

      context 'with no nickname' do
        before { post '/login' }
        it 'returns an unprocessable entity error' do
          expect(response).to have_http_status(422)
          expect(response.body).to match(/Parameter 'name' not found/)
        end
      end

      context 'with an invalid nickname' do
        before { post '/login', params: { name: '++===--===++'} }
        it 'returns an unprocessable entity error' do
          expect(response.body).to match(/Invalid nickname/)
          expect(response).to have_http_status(422)
        end
      end

    end

    context 'when an old user logs in' do
      context 'with a valid nickname' do
        context 'that was used by him last time' do
        end

        context 'that is new' do
        end

        context 'that is offline (available)' do
        end

        context 'that is online (unavailable)' do
        end
      end

      context 'with no nickname' do
      end

      context 'with an invalid nickname' do
      end
    end
  end


  #   # set headers for authorization
  #   let(:headers) { valid_headers.except('Authorization') }

  #   # set test valid and invalid credentials
  #   let(:valid_credentials) do
  #     {
  #       name: offline_nick.name
  #     }.to_json
  #   end
  #   let(:invalid_nick_credentials) do
  #     {
  #       name: '123456',
  #     }.to_json
  #   end

  #   # set request.headers to our custon headers
  #   # before { allow(request).to receive(:headers).and_return(headers) }

  #   # returns auth token when request is valid
  #   context 'When request is valid' do
  #     let(:nick) { offline_nick }
  #     before { post '/login', params: valid_credentials, headers: headers }

  #     it 'returns an authentication token' do
  #       expect(json['auth_token']).not_to be_nil
  #     end
  #   end

  #   # returns failure message when request is invalid
  #   context 'When request is invalid' do
  #     let(:nick) { offline_nick }
  #     before { post '/login', params: invalid_nick_credentials, headers: headers }

  #     it 'returns a failure message' do
  #       expect(json['message']).to match(/Nick not found/)
  #     end
  #   end
  # end
end
