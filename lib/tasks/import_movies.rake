require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    csv_file = Rails.root.join('db', 'movies.csv')

    CSV.foreach(csv_file, headers: true) do |row|
      Movie.create!(
        title: row['title'],
        description: row['description'],
        year: row['year'],
        director: row['director'],
        actor: row['actor'],
        filming_location: row['filming_location'],
        country: row['country']
      )
    end
  end
end
