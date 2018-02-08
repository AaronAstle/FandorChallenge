# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

30.times do
  @title = Faker::Book.title
  # title = @title
  # @url_slug = title.parameterize(separator: '_')

  film = Film.create!(
    title: @title,
    year: Faker::Time.between(DateTime.now - 10000, DateTime.now).year,
    description: Faker::Lorem.paragraph,
    related_film_ids: Array.new(4) { rand(1...30) },
    # url_slug: @url_slug,
    created_by: Faker::Number.between(1, 15)
  )
  film.ratings.create!(
    rating_value: Faker::Number.between(0, 5),
    comment: Faker::Lorem.sentence
  )
end
