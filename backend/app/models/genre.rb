class Genre < ApplicationRecord
    has_many :movies_genres, dependent: :destroy
    has_many :movies, through: :movies_genres
    has_many :tvshows_genres, dependent: :destroy
    has_many :tvshows, through: :tvshows_genres
end
  