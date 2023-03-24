# frozen_string_literal: true

require 'rails_helper'

describe 'user dashboard (show page)', :vcr do
  before do
    @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
    visit user_path(@user)
  end

  it 'has a header' do
    expect(page).to have_content("#{@user.name}'s Dashboard")
  end

  it 'has a section that lists viewing parties' do
    expect(page).to have_content('My Viewing Parties')
  end

  describe 'discover page button' do
    it 'has a button to discover movies' do
      expect(page).to have_button 'Discover Movies'
    end

    it 'links to a user\'s discover page' do
      click_button 'Discover Movies'
      expect(current_path).to eq(user_discover_path(@user))
    end
  end

  describe 'viewing parties section (invited)', :vcr do
    before do
      @user_2 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com')
      party = Party.create!(movie_id: 808, host_id: @user_2.id, date: '2023-01-01', time: '12:00', duration: 180)
      UserParty.create!(user_id: @user.id, party_id: party.id)
      UserParty.create!(user_id: @user_2.id, party_id: party.id)
      visit user_path(@user)
    end

    it 'should have the title for the party, which links to its show page', :vcr do
      within('#movie_808') do
        expect(page).to have_link("Shrek")
        click_link "Shrek"
        expect(current_path).to eq(user_movie_path(@user, 808))
      end
    end

    it 'should have the image for the movie' do
      within('#movie_808') do
        expect(page).to have_css('img[alt="Shrek"]')
      end
    end

    it 'should have the date and time for the party' do
      within('#movie_808') do
        save_and_open_page
       expect(page).to have_content("Date: January 01, 2023")
       expect(page).to have_content("Time: 12:00 PM")
      end
    end

    it 'should have who is hosting the event' do

    end

    it 'should have of users invited to the party, with user name in bold' do

    end
  end

  describe 'viewing parties section (hosting)', :vcr do
    before do
      @user_2 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com')
      party = Party.create!(movie_id: 808, host_id: @user.id, date: '2023-01-01', time: '12:00', duration: 180)
      UserParty.create!(user_id: @user.id, party_id: party.id)
      UserParty.create!(user_id: @user_2.id, party_id: party.id)
      visit user_path(@user)
    end

    it 'says that I am host of the party' do

    end
  end

  describe 'viewing parties (multiple)', :vcr do
    before do
      @lenny = User.create!(name: 'Lenny', email: 'Drunk@springfield.com')
      @bart = User.create!(name: 'Bart', email: 'Bart@springfield.com')
      @lisa = User.create!(name: 'Lisa', email: 'Lisa@springfield.com')
      shrek_party = Party.create!(movie_id: 808, host_id: @user.id, date: '2023-01-01', time: '12:00', duration: 180)
      godfather_party = Party.create!(movie_id: 238, host_id: @lenny.id, date: '2023-05-01', time: '13:00', duration: 180)
      UserParty.create!(user_id: @user.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @lenny.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @bart.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @lisa.id, party_id: shrek_party.id)

      UserParty.create!(user_id: @user.id, party_id: godfather_party.id)
      UserParty.create!(user_id: @bart.id, party_id: godfather_party.id)
      UserParty.create!(user_id: @lisa.id, party_id: godfather_party.id)
      visit user_path(@user)
    end

    it 'displays multiple parties' do

    end

    it 'has all the people invited to the parties' do

    end

    it 'says whether one is hosting or invited' do

    end
  end

end
