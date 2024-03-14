class Movie < ApplicationRecord
  has_many :reviews
  belongs_to :director
  has_many :appearances
  has_many :actors, through: :appearances
end
