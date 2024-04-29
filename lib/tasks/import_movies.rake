# lib/tasks/import.rake
require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    puts 'Rake task started...'
    ImportMoviesWorker.perform_async
  end
end
