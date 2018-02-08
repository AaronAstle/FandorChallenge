FactoryBot.define do
  factory :film do
    title { Faker::Lorem.word }
    year { Faker::Time.between(DateTime.now - 10000, DateTime.now) }
    description { Faker::Lorem.paragraph }
    related_film_ids { Faker::Types.array }
    url_slug { title.parameterize }
    created_by { Faker::Number.between(1, 10) }
  end
end
