# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    if params[:search].nil?
      @movies = MovieService.get_top_20
    elsif params[:search].blank?
      flash[:notice] = 'Field cannot be blank'
      redirect_to discover_path
    else
      @movies = MovieService.get_movies(params[:search])
    end
  end

  def show
    @movie = MovieService.get_full_movie(params[:id])
  end
end
