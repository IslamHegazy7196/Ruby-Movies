# lib/tasks/import_reviews.rake

require 'csv'

namespace :import do
  desc 'Import reviews from CSV'
  task reviews: :environment do
    csv_file = Rails.root.join('db', 'reviews.csv')

    begin
      Review.transaction do
        CSV.foreach(csv_file, headers: true) do |row|
          movie = Movie.find_by(title: row['Movie'])
          if movie
            Review.create!(
              movie_id: movie.id,
              user: row['User'],
              stars: row['Stars'],
              review: row['Review']
            )
          else
            puts "Movie with title '#{row['Movie']}' not found."
          end
        rescue StandardError => e
          puts "Error importing review: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
    rescue StandardError => e
      puts "Transaction failed: #{e.message}"
    end
  end
end
