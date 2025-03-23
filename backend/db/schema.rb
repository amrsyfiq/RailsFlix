# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_23_172251) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "file_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0, null: false
    t.date "release_date"
    t.integer "score"
    t.bigint "director_id", null: false
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["image_id"], name: "index_movies_on_image_id"
  end

  create_table "movies_actors", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movies_actors_on_movie_id"
    t.index ["person_id"], name: "index_movies_actors_on_person_id"
  end

  create_table "movies_genres", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movies_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movies_genres_on_movie_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tvshows", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0, null: false
    t.date "release_date"
    t.integer "score"
    t.bigint "director_id", null: false
    t.bigint "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["director_id"], name: "index_tvshows_on_director_id"
    t.index ["image_id"], name: "index_tvshows_on_image_id"
  end

  create_table "tvshows_actors", force: :cascade do |t|
    t.bigint "tvshow_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_tvshows_actors_on_person_id"
    t.index ["tvshow_id"], name: "index_tvshows_actors_on_tvshow_id"
  end

  create_table "tvshows_genres", force: :cascade do |t|
    t.bigint "tvshow_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_tvshows_genres_on_genre_id"
    t.index ["tvshow_id"], name: "index_tvshows_genres_on_tvshow_id"
  end

  add_foreign_key "movies", "images"
  add_foreign_key "movies", "people", column: "director_id"
  add_foreign_key "movies_actors", "movies"
  add_foreign_key "movies_actors", "people"
  add_foreign_key "movies_genres", "genres"
  add_foreign_key "movies_genres", "movies"
  add_foreign_key "tvshows", "images"
  add_foreign_key "tvshows", "people", column: "director_id"
  add_foreign_key "tvshows_actors", "people"
  add_foreign_key "tvshows_actors", "tvshows"
  add_foreign_key "tvshows_genres", "genres"
  add_foreign_key "tvshows_genres", "tvshows"
end
