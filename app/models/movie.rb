class Movie < ApplicationRecord
  has_many :reviews
  belongs_to :director
  has_many :appearances
  has_many :actors, through: :appearances
  has_many :movie_filming_locations
  has_many :filming_locations, through: :movie_filming_locations
end
