class TvshowsActor < ApplicationRecord
    belongs_to :tvshow
    belongs_to :person
  end
  