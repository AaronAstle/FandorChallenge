class FilmSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :description,
    :year,
    :url_slug,
    :related_film_ids,
    :average_rating,
    :created_by,
    :updated_at

  has_many :ratings
end
