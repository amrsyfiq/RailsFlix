class CreateJoinTableTvshowsActors < ActiveRecord::Migration[8.0]
  def change
    create_table :tvshows_actors do |t|
      t.references :tvshow, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
