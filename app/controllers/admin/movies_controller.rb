# app/controllers/admin/movies_controller.rb
class Admin::MoviesController < ApplicationController
  def import
    ImportMoviesWorker.perform_async
    redirect_to admin_movies_path, notice: 'Movie import has started in the background.'
  end
end
