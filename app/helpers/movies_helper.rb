# app/helpers/movies_helper.rb

module MoviesHelper
  def average_rating(movie)
    reviews_count = movie.reviews.count

    return 0 unless reviews_count > 0

    total_rating = movie.reviews.sum(:stars).to_f
    average_rating = total_rating / reviews_count
    average_rating.round(2) # Round to two decimal places

    # or any default value you prefer when there are no reviews
  end
end
