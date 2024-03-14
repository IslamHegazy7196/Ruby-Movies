class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.references :director, foreign_key: true
    end
  end
end
