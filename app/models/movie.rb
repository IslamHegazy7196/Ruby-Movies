class Movie < ApplicationRecord
  has_many :reviews
  belongs_to :director
end
