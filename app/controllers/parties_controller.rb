# frozen_string_literal: true

class PartiesController < ApplicationController
  def new
    if session[:user_id]
      @movie = MovieService.get_movie(params[:movie_id])
      @user = User.find(session[:user_id])
      @users = User.where.not(id: @user.id)
    else
      flash[:notice] = "You must be logged in or registered to create a viewing party"
      redirect_to movie_path(params[:movie_id])
    end
  end

  def create
    party = Party.new(movie_id: params[:movie_id],
                      date: Date.new(params['date(1i)'].to_i, params['date(2i)'].to_i, params['date(3i)'].to_i),
                      time: params[:start_time], duration: params[:duration], host_id: session[:user_id])

    if party.save

      params[:guest_id].each do |guest|
        UserParty.create!(user_id: guest[0], party_id: party.id) if (guest[1] = '1')
      end
      UserParty.create!(user_id: session[:user_id], party_id: party.id)

      redirect_to dashboard_path
    else
      flash[:error] = party.errors.full_messages.join(', ')
      redirect_to movie_viewing_party_new_path(params[:movie_id])
    end
  end
end
