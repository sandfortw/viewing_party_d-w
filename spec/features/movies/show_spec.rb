# frozen_string_literal: true

require 'rails_helper'

describe 'movie details page' do
  before do
    VCR.use_cassette('Shrek') do
      @user = User.create!(name: 'Donkey', email: 'donkey@swampify.com')
      visit user_movie_path(@user, 808)
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

    it 'when the button is clicked, it goes somewhere else' do
      click_button('Create Viewing Party for Shrek')
      expect(current_path).to eq("/users/#{@user.id}/movies/808/viewing-party/new")
    end
  end

  context 'more details' do
    it 'should have the summary for the movie' do
      within('#summary') do
        expect(page).to have_content('Summary')
        expect(page).to have_content("It ain't easy bein' green -- especially if you're a likable (albeit smelly) ogre named Shrek. On a mission to retrieve a gorgeous princess from the clutches of a fire-breathing dragon, Shrek teams up with an unlikely compatriot -- a wisecracking donkey.")
      end
    end

    it 'should have the first 10 cast members for a movie' do
      within('#cast') do
        expect(page).to have_content('Cast')
        expect(page).to have_content('Mike Myers')
        expect(page).to have_content('Eddie Murphy')
        expect(page).to have_content('Cameron Diaz')
        expect(page).to have_content('John Lithgow')
        expect(page).to have_content('Vincent Cassel')
        expect(page).to have_content('Peter Dennis')
        expect(page).to have_content('Clive Pearse')
        expect(page).to have_content('Jim Cummings')
        expect(page).to have_content('Bobby Block')
        expect(page).to have_content('Chris Miller')
        expect(page).to_not have_content('Cody Cameron') # Number 11
        expect(page).to have_css('#cast_member', count: 10)
      end
    end

    it 'should have the reviews for the movie' do
      within('#reviews') do
        expect(page).to have_content('Author: Cwf97')
        expect(page).to have_content('Shrek is a masterpiece! It helped subvert the Disney Renaissance formula with great humor and heart. Myers, Murphy, Diaz and Lithgow did a great job voicing the characters. Now that this film is 20 years old, I am glad it existed.')
        expect(page).to have_content('Author: GenerationofSwine')
        expect(page).to have_content('Author: 핸키')
      end
    end

    it 'should have a count of the number of reviews' do
      within('#reviews') do
        expect(page).to have_content('Review Count: 3')
      end
    end
  end
end
