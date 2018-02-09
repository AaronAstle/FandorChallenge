require 'rails_helper'

RSpec.describe AuthenticateUser do

  let(:user) { create(:user) }

  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new('lots', 'ofnope') }

  describe "Auth" do

    context 'When Valid' do
      it 'Returns with Auth Token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'When Invalid' do
      it 'Raises Auth Error' do
        expect { invalid_auth_obj.call }
          .to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
    end

  end

end
