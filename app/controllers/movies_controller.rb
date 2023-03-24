# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    @user = User.find(params[:user_id])
    if params[:search].nil?
      response = conn.get('/3/movie/top_rated?&page=1')
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results].map do |movie|
        Movie.new(movie)
      end
    elsif params[:search].blank?
      flash[:notice] = 'Field cannot be blank'
      redirect_to user_discover_path(@user)
    else
      response = conn.get("/3/search/movie?&query=#{params[:search]}&page=1&include_adult=false")
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results].map do |movie|
        Movie.new(movie)
      end
    end

  end

  def show
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    @user = User.find(params[:user_id])

    response = conn.get("3/movie/#{params[:id]}")
    movie_data = JSON.parse(response.body, symbolize_names: true)

    response = conn.get("3/movie/#{params[:id]}/credits?page=1")
    cast_data = JSON.parse(response.body, symbolize_names: true)

    response = conn.get("3/movie/#{params[:id]}/reviews")
    review_data = JSON.parse(response.body, symbolize_names: true)

    @movie = Movie.new(movie_data, cast_data, review_data)
  end
end
