# frozen_string_literal: true

require 'rails_helper'

describe 'discover movies page' do
  before do
    @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
    visit user_discover_path(@user)
  end

  it 'should have a header' do
    expect(page).to have_css('h1', text: 'Discover Movies')
  end

  context 'top rated button' do
    it 'should have a button to discover top rated movies' do
      expect(page).to have_button 'Find Top Rated Movies'
    end

    it 'when clicked it should take us to movie results' do
      VCR.use_cassette('top_20') do
        click_button 'Find Top Rated Movies'
        expect(current_path).to eq(user_movies_path(@user))
      end
    end
  end

  context 'search form' do
    it 'should have a text field to search by movie title' do
      within('#search_form') do
        expect(page).to have_content 'Search by title:'
        expect(page).to have_field(:search)
      end
    end

    it 'should have a button to search' do
      within('#search_form') do
        expect(page).to have_button 'Find Movies'
      end
    end

    it "redirects the user to the movie index once the user fills in the search field and clicks 'Find Movies'" do
      VCR.use_cassette('search_test') do
        fill_in :search, with: 'Test'
        click_button 'Find Movies'
        expect(current_path).to eq(user_movies_path(@user))
      end
    end

    it 'flashes a message when field is blank' do
      VCR.use_cassette('search_test') do
        fill_in :search, with: ''
        click_button 'Find Movies'
        expect(current_path).to eq(user_discover_path(@user))
        expect(page).to have_content('Field cannot be blank')
      end
    end
  end
end
