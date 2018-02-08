class FilmSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :description,
    :year,
    :url_slug,
    :related_film_ids,
    :average_rating,
    :updated_at

  has_many :ratings
end
