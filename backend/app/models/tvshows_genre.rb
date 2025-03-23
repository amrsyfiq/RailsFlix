class TvshowsGenre < ApplicationRecord
  belongs_to :tvshow
  belongs_to :genre
end
