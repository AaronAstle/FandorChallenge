require 'rails_helper'

RSpec.describe 'Ratings API' do
  let!(:film) { create(:film) }
  let!(:rating) { create_list(:rating, 30, film_id: film.id) }
  let(:film_id) { film.id }
  let(:id) {ratings.first.id }

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

end
