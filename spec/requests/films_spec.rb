require 'rails_helper'

RSpec.describe 'Films API', type: :request do
  let!(:films) { create_list(:film, 10) }
  let(:film_id) { films.first.id }

  describe 'Get /films' do
    before { get '/films' }

    it 'Returns Films' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'Returns a 200 Status Code' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /films/:id' do
    before { get "/films/#{film_id}" }

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
    let(:valid_attributes) { {
      title: 'Star Wars',
      year: '1984',
      description: "A story in a far away galaxy.",
      created_by: 1 } }

    context 'Valid POST' do
      before { post '/films', params: valid_attributes }

      it 'Creates a Film' do
        expect(json['title']).to eq('Star Wars')
        expect(json['url_slug']).to eq('star_wars')
      end

      it 'Returns a 201 Status Code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'Invalid POST' do
      before { post '/films', params: { title: 'Not the right Title' } }

      it 'Returns 422 Status Code' do
        expect(response).to have_http_status(422)
      end

      it 'Returns a "Failure" Message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /films/:id' do
    let(:valid_attributes) { { title: 'Spaceballs' } }

    context 'When a matching record exists' do
      before { put "/films/#{film_id}", params: valid_attributes }

      it 'Updates the record' do
        expect(response.body).to be_empty
      end

      it 'Returns a 204 Status Code' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /films/:id' do
    before { delete "/films/#{film_id}" }

    it 'Returns a 204 Status Code' do
      expect(response).to have_http_status(204)
    end
  end
end
