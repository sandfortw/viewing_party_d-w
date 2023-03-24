# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search].nil?
      @movies = MovieService.get_top_20
    elsif params[:search].blank?
      flash[:notice] = 'Field cannot be blank'
      redirect_to user_discover_path(@user)
    else
      @movies = MovieService.get_movies(params[:search])
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieService.get_full_movie(params[:id])
  end
end
