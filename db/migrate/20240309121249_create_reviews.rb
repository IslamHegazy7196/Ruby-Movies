class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :movie, foreign_key: true
      t.string :user
      t.integer :stars
      t.text :review
    end
  end
end
