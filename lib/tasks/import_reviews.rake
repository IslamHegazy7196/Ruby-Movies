# lib/tasks/import_reviews.rake

require 'csv'

namespace :import do
  desc 'Import reviews from CSV'
  task reviews: :environment do
    csv_file = Rails.root.join('db', 'reviews.csv')

    CSV.foreach(csv_file, headers: true) do |row|
      Review.create!(
        movie_id: Movie.find_by(title: row['movie']).id,
        user: row['user'],
        stars: row['stars'],
        review: row['review']
      )
    end
  end
end
