require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  subject(:invalid_req_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  describe 'Request Call' do

    context 'Valid Request' do
      it 'Returns User' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'Invalid Requests' do
      context 'when missing token' do
        it 'Raises a MissingToken' do
          expect { invalid_req_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
        end
      end

      context 'Invalid Token' do
        subject(:invalid_req_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'Raises InvalidToken' do
          expect { invalid_req_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'Taken Expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'Raises Expired error' do
          expect{ request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /expired/)
        end
      end

      context 'Imposter Token' do
        let(:header) { { 'Authorizatoin' => 'foobar' } }
        subject(:invlaid_req_obj) { described_class.new(header) }

        it 'Throws to JWT for exception' do
          expect{ invalid_req_obj.call}
            .to raise_error(ExceptionHandler::InvalidToken, /Not enough or too many segments/)
        end
      end
    end
  end
end
