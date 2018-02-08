require 'rails_helper'

RSpec.describe 'Ratings API' do
  let!(:film) { create(:film) }
  let!(:rating) { create_list(:rating, 30, film_id: film.id) }
  let(:film_id) { film.id }
  let(:id) {rating.first.id }

  describe 'GET /films/:film_id/ratings' do
    before { get "/films/#{film_id}/ratings" }

    context 'When a Film Exists' do
      it 'Returns 200 Status Code' do
        expect(response).to have_http_status(200)
      end

      it 'Returns All of the Film Ratings' do
        expect(json.size).to eq(30)
      end
    end

    context 'When Film doesnt exist' do
      let(:film_id) { 0 }

      it 'Returns 404 Status Code' do
        expect(response).to have_http_status(404)
      end

      it 'Returns Not Found Message' do
        expect(response.body).to match(/Couldn't find Film/)
      end
    end
  end

  describe 'POST /films/:film_id/ratings' do
    let(:valid_attributes) { { rating_value: 2, comment: "It was meh." } }

    context 'When request attrs are valid' do
      before { post "/films/#{film_id}/ratings", params: valid_attributes }

      it 'Returns 201 Status Code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'When Request isnt valid' do
      before { post "/films/#{film_id}/ratings", params: {} }

      it 'Returns 422 Status Code' do
        expect(response).to have_http_status(422)
      end

      it 'Returns a Failed Message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /films/:film_id/ratings/:id' do
    let(:valid_attributes) { { rating_value: 5 } }

    before { put "/films/#{film_id}/ratings/#{id}", params: valid_attributes }

    context 'When Rating exists' do
      it 'Returns 204 Status Code' do
        expect(response).to have_http_status(204)
      end

      it 'Updates the Rating' do
        updated_rating = Rating.find(id)
        expect(updated_rating.rating_value).to eq(5)
      end
    end

    context 'When Rating record doesnt exist' do
      let(:id) { 0 }

      it 'Returns 404 Status Code' do
        expect(response).to have_http_status(404)
      end

      it 'Returns Not Found Message' do
        expect(response.body).to match(/Couldn't find Rating/)
      end
    end
  end

  describe 'DELETE /films/:film_id/ratings/:id' do
    before { delete "/films/#{film_id}/ratings/#{id}" }

    it 'Returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
