# frozen_string_literal: true

require 'faker'
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    role { 'Software Engineer' }
    password_digest { Faker::Internet.password }
  end
end
