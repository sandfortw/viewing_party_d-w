class MoviesController < ApplicationController

  def index
    #TOP 20
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    @user = User.find(params[:user_id])
    if params[:search].nil?
      response = conn.get('/3/movie/top_rated?&page=1')
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results]
    elsif params[:search].blank?
      flash[:notice] = "Field cannot be blank"
      redirect_to user_discover_path(@user)
    else
      response = conn.get("/3/search/movie?&query=#{params[:search]}&page=1&include_adult=false")
      data = JSON.parse(response.body, symbolize_names: true)
      @movies = data[:results]
    end
  end

  def show
   
  end
end