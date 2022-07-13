require 'bcrypt'

class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  # users.password_hash in the database is a :string
  include BCrypt

  has_secure_password
end
