# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(params[:id])
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.headers['Authorization'] = ENV['movie_db_token']
    end
    @movies = @user.parties.map do |party|
      response = conn.get("3/movie/#{party.movie_id}")
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "User: #{user.name}, has been created!"
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.join(', ')
      redirect_to register_path
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
