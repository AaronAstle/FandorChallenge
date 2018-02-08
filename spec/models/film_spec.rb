require 'rails_helper'

RSpec.describe Film, type: :model do
  let!(:film) { create(:film) }
  let!(:rating) { create(:rating, rating_value: 4, film_id: film.id) }
  let!(:rating2) { create(:rating, rating_value: 2, film_id: film.id) }
  let(:film_id) { film.id }

  it { should have_many(:ratings).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:url_slug) }
  it { should validate_presence_of(:created_by) }

  describe 'Average Rating for Film' do
    it 'Returns an average_rating' do
      # Average of 2 and 4 is 3
      expect(film.average_rating).to eq(3);
    end
  end

end
