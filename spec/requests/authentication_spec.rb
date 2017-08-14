require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  # Authentication test suite
  describe 'POST /login' do
    # create test nicks
    let(:online_nick) { create(:nick, status: 'online') }
    let(:offline_nick) { create(:nick, status: 'offline') }
    let(:nick) { online_nick }

    shared_examples 'nick grab' do |code|
      it "responds with code #{code}" do
        expect(response).to have_http_status(code)
      end

      it 'returns an authetication token' do
        expect(json['auth_token']).not_to be_nil
      end

      it 'sets nick online' do
        get "/nicks/#{params[:name]}", headers: valid_headers
        expect(json['status']).to eq('online')
      end

    end

    context 'when new user logs in' do
      before { post '/login', params: params }

      context 'with a valid nickname' do
        context 'that is new' do
          let(:params) { { name: 'roland1337' } }

          include_examples 'nick grab', 201

          it 'creates nick' do
            expect(Nick.all.count).to eq(1)
          end
        end

        context 'that is offline (available)' do
          let(:params) { { name: offline_nick.name } }

          include_examples 'nick grab', 201
        end

        context 'that is online (unavailable)' do
          let(:params) { { name: online_nick.name } }

          it 'returns a forbidden error' do
            expect(response).to have_http_status(403)
            expect(response.body).to match(/Nickname already in use/)
          end
        end
      end

      context 'with no nickname' do
        let(:params) { { } }
        it 'returns an unprocessable entity error' do
          expect(response).to have_http_status(422)
          expect(response.body).to match(/Parameter 'name' not found/)
        end
      end

      context 'with an invalid nickname' do
        let(:params) { { name: '++===--===++' } }
        it 'returns an unprocessable entity error' do
          expect(response).to have_http_status(422)
          expect(response.body).to match(/Invalid nickname/)
        end
      end

    end

    context 'when an old user logs in' do
      let(:nick) { create(:nick, status: 'offline') }
      let(:headers) { valid_headers }

      shared_examples 'token renewal' do
        it 'returns an updated authentication token' do
          expect(json['auth_token']).not_to eq(headers['Authorization'])
        end
      end

      context 'with a valid nickname' do
        before { post '/login', params: params.to_json, headers: headers }

        context 'that was used by him last time' do
          let(:params) { { name: nick.name } }

          context 'with valid token' do
            include_examples 'nick grab', 201
            include_examples 'token renewal'
          end

          context 'with an expired token' do
            let(:headers) { expired_headers }
            include_examples 'nick grab', 201
            include_examples 'token renewal'
          end
        end

        context 'that is new' do
          let(:params) { { name: 'roland1337' } }
          include_examples 'nick grab', 201
          include_examples 'token renewal'
        end

        context 'that is offline (available)' do
          let(:params) { { name: offline_nick.name } }
          include_examples 'nick grab', 201
          include_examples 'token renewal'
        end

        context 'that is online (unavailable)' do
          let(:params) { { name: online_nick.name } }

          it 'returns a forbidden error' do
            expect(response).to have_http_status(403)
            expect(response.body).to match(/Nickname already in use/)
          end

        end
      end

      context 'with no nickname' do
        let(:params) { { name: nick.name } }
        before { post '/login', params: {}.to_json, headers: headers }

        context 'with valid token' do
          include_examples 'nick grab', 201
          include_examples 'token renewal'
        end

        context 'with an expired token' do
          let(:headers) { expired_headers }

          it 'returns an unprocessable entity error' do
            expect(response).to have_http_status(422)
            expect(response.body).to match(/Invalid token/)
          end
        end
      end

      context 'with an invalid nickname' do
      end
    end
  end
end
