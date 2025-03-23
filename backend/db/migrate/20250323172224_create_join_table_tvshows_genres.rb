class CreateJoinTableTvshowsGenres < ActiveRecord::Migration[8.0]
  def change
    create_table :tvshows_genres do |t|
      t.references :tvshow, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
