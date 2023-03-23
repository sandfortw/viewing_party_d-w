# frozen_string_literal: true

class MovieFacade
  def initialize(movie)
    @movie = movie
  end

  def top_movies
    service = MovieService.new

    json = service.top_rated_movies

    @top_movies = json[:results].map do |movie_data|
      TopMovie.new(movie_data)
    end
  end
end
