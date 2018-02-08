FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'John@smith.com'
    password 'password'
  end
end
