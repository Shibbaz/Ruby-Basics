require "faker"
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    role { "Software Engineer" }
    password { Faker::Internet.password }
  end
end