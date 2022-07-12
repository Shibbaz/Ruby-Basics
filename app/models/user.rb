require 'bcrypt'

class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
