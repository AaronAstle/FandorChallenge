class Film < ApplicationRecord
  has_many :ratings, dependent: :destroy

end
