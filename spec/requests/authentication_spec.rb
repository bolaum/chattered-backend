require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do
  # # Authentication test suite
  # describe 'POST /login' do
  #   # create test nicks
  #   let(:online_nick) { create(:nick, status: 'online') }
  #   let(:offline_nick) { create(:nick, status: 'offline') }
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
  #       name: "123456",
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
