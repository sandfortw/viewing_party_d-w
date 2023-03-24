# frozen_string_literal: true

require 'rails_helper'

describe MovieService do
  describe 'class methods' do
    describe '.get_movies()' do
      it 'returns movie array', :vcr do
        list = MovieService.get_movies('Shrek')
        expect(list).to be_an Array
        expect(list.first).to be_a(Movie)
      end
    end

    describe '.get_movie(url)' do
      it 'returns a movie object', :vcr do
        movie = MovieService.get_movie(808)
        expect(movie).to be_a Movie
      end
    end

    describe '.get_full_movie(url)' do
      it 'returns a movie with reviews and cast', :vcr do
        movie = MovieService.get_full_movie(808)
        expect(movie).to be_a Movie
        expect(movie.cast).to be_an Array
        expect(movie.reviews).to be_an Array
      end
    end

    describe '.get_top_20(url)' do
      it 'it returns 20 movies as an array', :vcr do
        list = MovieService.get_top_20
        expect(list).to be_an Array
        expect(list.first).to be_a(Movie)
      end
    end
  end
end
