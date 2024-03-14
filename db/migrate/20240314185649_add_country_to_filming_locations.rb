class AddCountryToFilmingLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :filming_locations, :country, :string
  end
end
