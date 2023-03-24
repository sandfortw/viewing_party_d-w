# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :time, presence: true
  validates :date, presence: true
  validates :host_id, presence: true
  validates :movie_id, presence: true
  validates :duration, presence: true

  def movie
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    response = conn.get("3/movie/#{movie_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def host_name
    User.find(host_id).name
  end
end
