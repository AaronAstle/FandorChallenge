class Rating < ApplicationRecord
  # Association
  belongs_to :film

  # Validationg
  validates_presence_of :rating
end
