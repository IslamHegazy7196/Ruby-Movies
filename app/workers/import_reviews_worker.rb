# app/workers/import_reviews_worker.rb
class ImportReviewsWorker
  include Sidekiq::Worker

  def perform
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
        end
      end
    rescue StandardError => e
      puts "Error importing review: #{e.message}"
      raise ActiveRecord::Rollback
    end
  end
end
