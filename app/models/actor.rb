class Actor < ApplicationRecord
  has_many :appearances
  has_many :movies, through: :appearances
end
