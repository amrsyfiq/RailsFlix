class Movie < ApplicationRecord
  enum :status, { Unpublished: 1, Released: 2, Upcoming: 3, Archived: 4 }

  def self.statuses_list
    statuses.map { |key, value| { id: value, name: key.humanize } }
  end

  has_many :movies_genres, dependent: :destroy
  has_many :genres, through: :movies_genres

  belongs_to :director, class_name: "Person", foreign_key: "director_id"
  belongs_to :image, class_name: "Image", foreign_key: "image_id", optional: true

  has_many :movies_actors, dependent: :destroy
  has_many :actors, through: :movies_actors, source: :person
end
