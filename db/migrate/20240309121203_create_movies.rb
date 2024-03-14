class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.references :director, foreign_key: true
      t.string :actor
      t.string :filming_location
      t.string :country
    end
  end
end
