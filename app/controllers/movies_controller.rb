class MoviesController < ApplicationController
  include MoviesHelper
  def index
    @actor = params[:search] ? params[:search][:actor] : ''
    @movies = Movie.left_outer_joins(:reviews)
                   .select('movies.*, COALESCE(AVG(reviews.stars), 0) AS avg_rating')
                   .joins(:actors).where('actors.name LIKE ?', "%#{@actor}%")
                   .group('movies.id')
                   .order('avg_rating DESC')
  end
end
