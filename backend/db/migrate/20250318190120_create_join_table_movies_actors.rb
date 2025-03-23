class CreateJoinTableMoviesActors < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_actors do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
