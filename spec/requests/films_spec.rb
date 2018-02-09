require 'rails_helper'

RSpec.describe 'Films API', type: :request do
  let(:user) { create(:user) }
  let!(:films) { create_list(:film, 10, created_by: user.id) }
  let(:film_id) { films.first.id }
  let(:headers) { valid_headers }

  describe 'Get /films' do
    before { get '/films', params: {}, headers: headers }

    it 'Returns Films' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'Returns a 200 Status Code' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /films/:id' do
    before { get "/films/#{film_id}", params: {}, headers: headers }

    context 'When a record exists' do
      it 'returns the film' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(film_id)
      end

      it 'Returns a 200 Status Code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'When a record does NOT exist' do
      let(:film_id) { 100 }

      it 'Returns a 404 Status Code' do
        expect(response).to have_http_status(404)
      end

      it 'Returns a "Not Found" message' do
        expect(response.body).to match(/Couldn't find Film/)
      end
    end
  end

  describe 'POST /films' do
    let(:valid_attributes) do
      {
        title: 'Star Wars',
        year: '1984',
        description: "A story in a far away galaxy.",
        created_by: user.id.to_s
      }.to_json
    end

    context 'Valid POST' do
      before { post '/films', params: valid_attributes, headers: headers }

      it 'Creates a Film' do
        expect(json['title']).to eq('Star Wars')
        expect(json['url_slug']).to eq('star_wars')
      end

      it 'Returns a 201 Status Code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Invalid POST' do
      let(:invalid_params) do
        {
          title: nil
        }.to_json
      end
      before { post '/films', params: invalid_params, headers: headers }

      it 'Returns 422 Status Code' do
        expect(response).to have_http_status(422)
      end

      it 'Returns a "Failure" Message' do
        expect(json['message']).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /films/:id' do
    let(:valid_attributes) { { title: 'Spaceballs' }.to_json }

    context 'When a matching record exists' do
      before { put "/films/#{film_id}", params: valid_attributes, headers: headers }

      it 'Updates the record' do
        expect(response.body).to be_empty
      end

      it 'Returns a 204 Status Code' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /films/:id' do
    before { delete "/films/#{film_id}", params: {}, headers: headers}

    it 'Returns a 204 Status Code' do
      expect(response).to have_http_status(204)
    end
  end
end
