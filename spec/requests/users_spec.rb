require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /signup' do
    context 'Valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates new user' do
        expect(response).to have_http_status(201)
      end

      it 'Returns success' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'Returns an auth token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'Invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create new user' do
        expect(response).to have_http_status(422)
      end

      it 'Returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank/)
      end
    end
  end
end
