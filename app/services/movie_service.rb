# frozen_string_literal: true

class MovieService
  def self.get_movies(search)
    data = ApiService.movie_call("/3/search/movie?&query=#{search}&page=1&include_adult=false")
    data[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def self.get_top_20
    data = ApiService.movie_call('/3/movie/top_rated?&page=1')
    data[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def self.get_movie(movie_id)
    movie_data = ApiService.movie_call("3/movie/#{movie_id}")
    Movie.new(movie_data)
  end

  def self.get_full_movie(movie_id)
    movie_data = ApiService.movie_call("3/movie/#{movie_id}")
    cast_data = ApiService.movie_call("3/movie/#{movie_id}/credits?page=1")
    review_data = ApiService.movie_call("3/movie/#{movie_id}/reviews")
    Movie.new(movie_data, cast_data, review_data)
  end
end
