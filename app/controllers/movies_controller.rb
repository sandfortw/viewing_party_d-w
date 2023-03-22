class MoviesController < ApplicationController

  def index
    #TOP 20
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    response = conn.get('/3/movie/top_rated?&page=1')
    data = JSON.parse(response.body, symbolize_names: true)
    @movies = data[:results]
  end

  def show

  end

end