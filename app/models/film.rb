class Film < ApplicationRecord
  has_many :ratings, dependent: :destroy

  validates_presence_of :title, :description, :year, :created_by
end
