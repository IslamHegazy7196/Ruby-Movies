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
              year: row['Year']
            )

            unless movie.valid?
              puts "Validation failed for movie with title: #{movie.title}. Errors: #{movie.errors.full_messages.join(', ')}"
              next
            end
            # Create or find filming locations and associate with the movie
            locations_names = row['Filming location'].split(',') # Assuming locations are comma-separated
            locations = locations_names.map do |location_name|
              FilmingLocation.find_or_create_by(name: location_name.strip, country: row['Country'].strip) # Strip whitespace
            end

            # Save the filming locations to add them to the database
            locations.each(&:save)

            # Associate locations with the movie
            locations.each do |location|
              MovieFilmingLocation.create(movie: movie, filming_location: location)
            end

            # Create or find actors and associate with the movie
            actors_names = row['Actor'].split(',') # Assuming actors are comma-separated
            actors = actors_names.map do |actor_name|
              Actor.find_or_create_by(name: actor_name.strip) # Strip whitespace
            end

            actors.each do |actor|
              movie.appearances.create(actor: actor)
            end
          end
        end
      end
    rescue StandardError => e
      puts "An error occurred while importing movies: #{e.message}"
    end
  end
end

#  chunk -try catch - validation layer - relation transaction (isolated)-gem activerecord importer(bulk insert)-background job
