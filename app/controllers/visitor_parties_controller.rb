class VisitorPartiesController < ApplicationController

  def index
    flash[:notice] = "You must be logged in or registered to create a viewing party"
    redirect_to visitor_movies_path(:movie_id)
  end
end