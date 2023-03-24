# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Party New Page' do
  before do
    @user_1 = User.create!(name: 'Homer', email: 'Homer@springfield.com')
    @user_2 = User.create!(name: 'Krusty', email: 'Krusty@springfield.com')
    @user_3 = User.create!(name: 'Mr.Burns', email: 'CEO@springfield.com')
    VCR.use_cassette('Shrek') do
      visit user_movie_viewing_party_new_path(@user_1.id, 808)
    end
  end
  context 'viewing party details form' do
    it 'has a title' do
      expect(page).to have_content('Viewing Party Details')
      expect(page).to have_content('Create a Movie Party for Shrek')
    end

    it 'should have the movie title' do
      within('#details_form') do
        expect(page).to have_content('Movie Title: Shrek')
      end
    end

    it 'has field for duration of party' do
      within('#details_form') do
        expect(page).to have_field(:duration, with: 90)
      end
    end

    it 'has a field to select the day' do
      within('#details_form') do
        expect(page).to have_field('[date(1i)]')
        expect(page).to have_field('[date(2i)]')
        expect(page).to have_field('[date(1i)]')
      end
    end

    it 'has a field for start time' do
      within('#details_form') do
        expect(page).to have_field(:start_time)
      end
    end

    it 'has check box for other exisitng users in the system' do
      within('#details_form') do
        expect(page).to have_unchecked_field("_guest_id_#{@user_2.id}")
        expect(page).to have_unchecked_field("_guest_id_#{@user_3.id}")
      end
    end

    it 'has a button to create a party' do
      within('#details_form') do
        expect(page).to have_button 'Create Party'
      end
    end
  end

  describe 'happy path' do
    it 'submits the form with valid inputs', :vcr do
      fill_in :start_time, with: '3:33 PM'
      check "_guest_id_#{@user_2.id}"

      click_button 'Create Party'

      expect(current_path).to eq(user_path(@user_1))
    end
  end

  describe 'sad path' do
    it 'does not allow the user to submit a form with empty fields', :vcr do
      click_button 'Create Party'

      expect(current_path).to eq(user_movie_viewing_party_new_path(@user_1.id, 808))

      expect(page).to have_content("Time can't be blank")
    end
  end
end
