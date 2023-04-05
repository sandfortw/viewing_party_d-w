# frozen_string_literal: true

class PartiesController < ApplicationController
  def new
    @movie = MovieService.get_movie(params[:movie_id])
    @user = User.find(session[:user_id])
    @users = User.where.not(id: @user.id)
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

      redirect_to user_path(session[:user_id])
    else
      flash[:error] = party.errors.full_messages.join(', ')
      redirect_to movie_viewing_party_new_path(params[:movie_id])
    end
  end
end
