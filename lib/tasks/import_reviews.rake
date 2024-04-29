# lib/tasks/import_reviews.rake
require 'csv'

namespace :import do
  desc 'Import reviews from CSV'
  task reviews: :environment do
    ImportReviewsWorker.perform_async
  end
end
