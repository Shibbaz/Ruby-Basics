require "faker"
FactoryBot.define do
  factory :movie do
    imdb_id { Faker::Number.number(digits: 2) }
    title { Faker::Name.name }
    rating { Faker::Number.decimal(l_digits: 10) }
    rank { Faker::Number.number(digits: 2) }
    year { Faker::Number.number(digits: 4) }
    data { nil }
  end
end