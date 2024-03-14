class CreateMovieFilmingLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_filming_locations do |t|
      t.references :movie, foreign_key: true
      t.references :filming_location, foreign_key: true

      t.timestamps
    end
  end
end
