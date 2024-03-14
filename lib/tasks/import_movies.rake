# lib/tasks/import_movies.rake

require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    csv_file = Rails.root.join('db', 'movies.csv')

    begin
      batch_size = 1000
      Movie.transaction do
        CSV.foreach(csv_file, headers: true).each_slice(batch_size) do |rows_batch|
          rows_batch.each do |row|
            director_name = row['Director']
            director = Director.find_or_create_by(name: director_name)

            movie = director.movies.new(
              title: row['Movie'].presence || 'Default Title',
              description: row['Description'],
              year: row['Year'],
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
      end
    rescue StandardError => e
      puts "An error occurred while importing movies: #{e.message}"
    end
  end
end

#  chunk -try catch - validation layer - relation transaction (isolated)-gem activerecord importer(bulk insert)-background job
