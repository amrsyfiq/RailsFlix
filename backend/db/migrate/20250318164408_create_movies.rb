class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :status, default: 0, null: false
      t.date :release_date
      t.integer :score, default: 0, null: false
      t.references :director, null: false, foreign_key: { to_table: :people }
      t.references :image, null: true, foreign_key: true
      t.timestamps
    end
  end
end
