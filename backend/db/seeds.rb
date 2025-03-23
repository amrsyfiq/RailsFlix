require 'faker'

# Clear existing data to avoid duplication
puts "🧹 Cleaning up old data..."
ActiveRecord::Base.connection.disable_referential_integrity do
  [MoviesActor, MoviesGenre, Movie, TvshowsActor, TvshowsGenre, Tvshow, Genre, Image, Person, Admin].each(&:destroy_all)
end

puts "🌱 Seeding data..."

# Create admins
Admin.create!(email: "admin@example.com", password: "password")

# Create genres
genres = 10.times.map { Genre.create!(name: Faker::Book.genre) }

# Create directors and actors
actors = 15.times.map { Person.create!(name: Faker::Name.name, role: 1) } # Role 0 = Actor
directors = 5.times.map { Person.create!(name: Faker::Name.name, role: 2) } # Role 1 = Director

# Create movies with images and relationships
20.times do
  movie = Movie.create!(
    title: Faker::Movie.title,
    status: [1, 2, 3, 4].sample,
    release_date: Faker::Date.between(from: '2000-01-01', to: '2025-12-31'),
    score: rand(1..100),
    director_id: directors.sample.id,
  )

  # Assign random genres
  movie.genres << genres.sample(rand(1..3))

  # Assign random actors
  movie.actors << actors.sample(rand(2..5))
end

# Create TV shows
10.times do
  tvshow = Tvshow.create!(
    title: Faker::Movie.title,
    status: [1, 2, 3, 4].sample,
    release_date: Faker::Date.between(from: '2000-01-01', to: '2025-12-31'),
    score: rand(1..100),
    director_id: directors.sample.id,
  )
  
  # Assign random genres
  tvshow.genres << genres.sample(rand(1..3))

  # Assign random actors
  tvshow.actors << actors.sample(rand(2..5))
end

puts "✅ Seeding complete!"
