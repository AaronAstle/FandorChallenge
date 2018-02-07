FactoryBot.define do
  factory :film do
    title { Faker::Lorem.word }
    year { Faker::Time.between(DateTime.now - 10000, DataTime.now) }
    description { Faker::Lorem.paragraph }
    related_film_ids { Faker::Types.array.to_i }
    url_slug { title.strip }
    created_by { Faker::Number.number(10) }

  end
end
