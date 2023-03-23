# frozen_string_literal: true

class PartiesController < ApplicationController
  def new 
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end

    response = conn.get("3/movie/#{params[:movie_id]}")
    data = JSON.parse(response.body, symbolize_names: true)
    @movie = data
    
    @user = User.find(params[:user_id])
    @users = User.where.not(id: @user.id)
  end

  # def show
  #   conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
  #     faraday.headers['Authorization'] = ENV['movie_db_token']
  #   end
  #   @user = User.find(params[:user_id])
  #   response = conn.get("3/movie/#{params[:id]}")
  #   data = JSON.parse(response.body, symbolize_names: true)
  #   @movie = data
  #   response = conn.get("3/movie/#{params[:id]}/credits?&page=1")
  #   data = JSON.parse(response.body, symbolize_names: true)
  #   @cast = data[:cast]
  #   response = conn.get("3/movie/#{params[:id]}/reviews")
  #   data = JSON.parse(response.body, symbolize_names: true)
  #   @reviews = data[:results]
  # end
end
