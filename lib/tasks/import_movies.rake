require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    csv_file = Rails.root.join('db', 'movies.csv')

    begin
      batch_size = 1000
      CSV.foreach(csv_file, headers: true).each_slice(batch_size) do |rows_batch|
        rows_batch.each do |row|
          movie = Movie.new(
            title: row['Movie'].presence || 'Default Title',
            description: row['Description'],
            year: row['Year'],
            director: row['Director'],
            actor: row['Actor'],
            filming_location: row['Filming location'],
            country: row['Country']
          )

          unless movie.valid?
            puts "Validation failed for movie with title: #{movie.title}. Errors: #{movie.errors.full_messages.join(', ')}"
            next
          end

          movie.save!
        end
      end
    rescue StandardError => e
      puts "An error occurred while importing movies: #{e.message}"
    end
  end
end

#  chunk -try catch - validation layer - relation transaction (isolated)-gem activerecord importer(bulk insert)-background job
