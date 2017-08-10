require 'rails_helper'

RSpec.describe AuthenticateNick do
  # create test nicks
  let(:online_nick) { create(:nick, status: 'online') }
  let(:offline_nick) { create(:nick, status: 'offline') }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(offline_nick.name) }
  # unavailable request subject
  subject(:unavailable_auth_obj) { described_class.new(online_nick.name) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('123456') }

  # Test suite for AuthenticateNick#call
  describe '#call' do
    # return token when valid request
    context 'when valid nick' do
      context 'is offline' do
        it 'returns an auth token' do
          token = valid_auth_obj.call
          expect(token).not_to be_nil
        end
      end
      context 'is online' do
        it 'raises a forbidden error' do
        expect { unavailable_auth_obj.call }
          .to raise_error(
            ExceptionHandler::Forbidden,
            /Nick already in use/
          )
        end
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid nick name' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ActiveRecord::RecordNotFound,
            /Couldn't find Nick/
          )
      end
    end
  end
end
