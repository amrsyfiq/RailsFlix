class CreateJoinTableMoviesGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_genres do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
