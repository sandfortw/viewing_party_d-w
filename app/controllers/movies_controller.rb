# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search].nil?
      @movies = MovieService.new.get_movies('/3/movie/top_rated?&page=1')
    elsif params[:search].blank?
      flash[:notice] = 'Field cannot be blank'
      redirect_to user_discover_path(@user)
    else
      @movies = MovieService.new.get_movies("/3/search/movie?&query=#{params[:search]}&page=1&include_adult=false")
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieService.new.get_full_movie("3/movie/#{params[:id]}",
                                             "3/movie/#{params[:id]}/credits?page=1",
                                             "3/movie/#{params[:id]}/reviews")
  end
end
