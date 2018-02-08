class Film < ApplicationRecord
  before_save :title_to_slug, on: [:create, :update]

  has_many :ratings, dependent: :destroy

  validates_presence_of :title, :description, :year, :created_by

  def average_rating
    ratings.sum(:rating_value).to_f / ratings.count
  end

  private

  def title_to_slug
    self.url_slug = self.title.parameterize(separator: '_')
  end
end
