# frozen_string_literal: true

require 'rails_helper'

describe 'movie details page' do
  before do
    VCR.use_cassette('Shrek') do
      @user = User.create!(name: 'Donkey', email: 'donkey@swampify.com')
      visit user_movie_path(@user)
    end
  end

  context 'basic details' do
    it 'should show the details for a movie' do
      expect(page).to have_content('Shrek')
    end

    it 'should have the vote for a movie' do
      expect(page).to have_content('Vote 7.717')
    end

    it 'should have the formatted runtime for the movie' do
      expect(page).to have_content('Runtime 1hr 30min')
    end

    it 'should have the genres for a movie' do
      expect(page).to have_content('Genre: Animation, Comedy, Fantasy, Adventure, Family')
    end
  end

  context 'viewing party button' do
    it 'should have a button to create a viewing party' do
      expect(page).to have_button('Create Viewing Party for Shrek')
    end

    it 'when the button is clicked, it goes somewhere else' # TODO
  end

  context 'more details' do
    it 'should have the summary for the movie' do
      expect(page).to have_content("It ain't easy bein' green -- especially if you're a likable (albeit smelly) ogre named Shrek. On a mission to retrieve a gorgeous princess from the clutches of a fire-breathing dragon, Shrek teams up with an unlikely compatriot -- a wisecracking donkey.")
    end
    it 'should have the first 10 cast members for a movie' do
    end

    it 'should have the reviews for the movie' do
    end
  end
end
