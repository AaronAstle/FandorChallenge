require 'rails_helper'

RSpec.describe 'Authentication', type: :request do

  describe 'POST /auth/login' do
    let!(:user) { create(:user) }

    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context 'Valid Requests' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'Returns an User Auth Token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'Invalid Requests' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'Raises Error' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
