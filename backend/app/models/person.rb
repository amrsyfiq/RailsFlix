class Person < ApplicationRecord
  enum :role, { Actor: 1, Director: 2 }

  def self.roles_list
    roles.map { |key, value| { id: value, name: key.humanize } }
  end

  has_many :movies_actors, dependent: :destroy
  has_many :movies, through: :movies_actors
end
