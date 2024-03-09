# lib/tasks/import_reviews.rake

require 'csv'

namespace :import do
  desc 'Import reviews from CSV'
  task reviews: :environment do
    csv_file = Rails.root.join('db', 'reviews.csv')

    CSV.foreach(csv_file, headers: true) do |row|
      Review.create!(
        movie_id: Movie.find_by(title: row['Movie']).id,
        user: row['User'],
        stars: row['Stars'],
        review: row['Review']
      )
    end
  end
end
