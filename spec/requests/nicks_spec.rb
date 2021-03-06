require 'rails_helper'

RSpec.describe 'Nicks API', type: :request do
  # initialize test data
  let!(:nicks) { create_list(:nick, 10) }
  let(:nick) { nicks[0] }

  # Test suite for GET /nicks
  describe 'GET /nicks' do

    # make HTTP get request before each example
    before { get '/nicks', headers: valid_headers }

    it 'returns nicks' do
      expect(jsonapi.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  shared_examples "get valid nick record" do |nick_field|
    context 'when the record exists' do
      before { get "/nicks/#{nick_ref}", headers: valid_headers }

      it 'returns the nick' do
        expect(jsonapi).not_to be_empty
        expect(jsonapi[nick_field]).to eq(nick_ref.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  shared_examples "get invalid nick record" do |invalid_nick_ref|
    context 'when the record does not exist' do
      before { get "/nicks/#{invalid_nick_ref}", headers: valid_headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Nick not found/)
      end
    end
  end

  describe "GET /nicks/:id" do
    let(:nick_ref) { nicks.first.id }
    include_examples "get valid nick record", 'id'
    include_examples "get invalid nick record", 100
  end

  describe "GET /nicks/:name" do
    let(:nick_ref) { nicks.first.name }
    include_examples "get valid nick record", 'name'

    include_examples "get invalid nick record", '123456'

    describe "when the name has symbols" do
      names = Array.new(10) { FactoryGirl.generate :name_with_symbols }
      names.each do |name|
        it "returns the nick '#{name}'" do
          create(:nick, name: name)
          get "/nicks/#{name}", headers: valid_headers
          expect(jsonapi['name']).to eq(name)
        end
      end
    end
  end
end
