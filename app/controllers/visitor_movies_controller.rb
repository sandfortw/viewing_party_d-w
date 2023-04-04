# frozen_string_literal: true

class VisitorMoviesController < ApplicationController
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
    flash[:notice] = "You must be logged in or registered to create a viewing party" if params[:party] == 'true'
    @movie = MovieService.get_full_movie(params[:id])
  end
  
end
