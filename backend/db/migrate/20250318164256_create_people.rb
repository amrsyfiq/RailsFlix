class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :name
      t.integer :role, default: 0, null: false

      t.timestamps
    end
  end
end
