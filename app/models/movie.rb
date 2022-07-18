class Movie < ApplicationRecord
  validates :title, uniqueness: true
  self.per_page = 5
end
