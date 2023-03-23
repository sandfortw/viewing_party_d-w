# frozen_string_literal: true

class MovieService
  def top_rated_movies
    get_url('/3/movie/top_rated')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/') do |faraday|
      faraday.headers['Authorization'] = ENV['TMDB_API_KEY']
    end
  end
end
