require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    csv_file = Rails.root.join('db', 'movies.csv')

    CSV.foreach(csv_file, headers: true) do |row|
      Movie.create!(
        title: row['Movie'].presence || 'Default Title',
        description: row['Description'],
        year: row['Year'],
        director: row['Director'],
        actor: row['Actor'],
        filming_location: row['Filming location'],
        country: row['Country']
      )
    end
  end
end
