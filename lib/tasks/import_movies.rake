# lib/tasks/import.rake
require 'csv'

namespace :import do
  desc 'Import movies from CSV'
  task movies: :environment do
    puts 'Rake task started...'
    ImportMoviesWorker.perform_async
  end
end

#  chunk -try catch - validation layer - relation transaction (isolated)-gem activerecord importer(bulk insert)-background job
