# frozen_string_literal: true

class MovieService
  def get_movies(url)
    conn = make_conn
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].map do |movie|
      Movie.new(movie)
    end
  end

  def get_movie(url)
    conn = make_conn
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
    Movie.new(data)
  end

  def get_full_movie(movie_url, cast_url, review_url)
    conn = make_conn
    response = conn.get(movie_url)
    data = JSON.parse(response.body, symbolize_names: true)
    Movie.new(data, cast_data(cast_url), get_reviews(review_url))
  end

  def cast_data(cast_url)
    conn = make_conn
    response = conn.get(cast_url)
    cast_data = JSON.parse(response.body, symbolize_names: true)
  end

  def get_reviews(review_url)
    conn = make_conn
    response = conn.get(review_url)
    review_data = JSON.parse(response.body, symbolize_names: true)
  end

  def make_conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
  end
end
