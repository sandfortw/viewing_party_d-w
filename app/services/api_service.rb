# frozen_string_literal: true

class ApiService
  def self.movie_call(url)
    conn = make_conn
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

private
  def self.make_conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
  end
end
