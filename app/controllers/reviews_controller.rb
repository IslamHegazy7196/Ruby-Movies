class ReviewsController < ApplicationController
  def index
    @movie_id = params[:movie_id]

    @reviews = if @movie_id.present?
                 Review.where(movie_id: @movie_id)
               else
                 Review.all
               end

    @movies = Movie.all
  end
end
