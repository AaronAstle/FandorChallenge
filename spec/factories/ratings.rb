FactoryBot.define do
  factory :rating do
    rating_value { Faker::Number.between(0, 5) }
    comment { Faker::Lorem.sentence }

    film_id nil

  end
end
