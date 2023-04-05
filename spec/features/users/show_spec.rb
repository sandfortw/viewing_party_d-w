# frozen_string_literal: true

require 'rails_helper'

describe 'user dashboard (show page)', :vcr do
  before do
    @user = User.create!(name: 'Homer', email: 'Homer@springfield.com', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
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
      expect(current_path).to eq(discover_path)
    end
  end

  describe 'viewing parties section (invited)', :vcr do
    before do
      @user_2 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com', password: 'password')
      party = Party.create!(movie_id: 808, host_id: @user_2.id, date: '2023-01-01', time: '12:00', duration: 180)
      UserParty.create!(user_id: @user.id, party_id: party.id)
      UserParty.create!(user_id: @user_2.id, party_id: party.id)
      visit dashboard_path
    end

    it 'should have the title for the party, which links to its show page', :vcr do
      within('#movie_808') do
        expect(page).to have_link('Shrek')
        click_link 'Shrek'
        expect(current_path).to eq(movie_path(808))
      end
    end

    it 'should have the image for the movie' do
      within('#movie_808') do
        expect(page).to have_css('img[alt="Shrek"]')
      end
    end

    it 'should have the date and time for the party' do
      within('#movie_808') do
        expect(page).to have_content('Date: January 01, 2023')
        expect(page).to have_content('Time: 12:00 PM')
      end
    end

    it 'should have who is hosting the event' do
      within('#movie_808') do
        expect(page).to have_content('Host is Lenny')
      end
    end

    it 'should have of users invited to the party, with user name in bold' do
      within('#invited') do
        expect(page).to have_css('strong', text: 'Homer')
        expect(page).to have_content('Lenny')
      end
    end

    it 'does not say that I am host of the party' do
      expect(page).to_not have_content('I am Hosting')
    end
  end

  describe 'viewing parties section (hosting)', :vcr do
    before do
      @user_2 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com', password: 'password')
      party = Party.create!(movie_id: 808, host_id: @user.id, date: '2023-01-01', time: '12:00', duration: 180)
      UserParty.create!(user_id: @user.id, party_id: party.id)
      UserParty.create!(user_id: @user_2.id, party_id: party.id)
      visit dashboard_path
    end

    it 'says that I am host of the party' do
      expect(page).to have_content('I am Hosting')
    end
  end

  describe 'viewing parties (multiple)', :vcr do
    before do
      @lenny = User.create!(name: 'Lenny', email: 'Drunk@springfield.com', password: 'password')
      @bart = User.create!(name: 'Bart', email: 'Bart@springfield.com', password: 'password')
      @lisa = User.create!(name: 'Lisa', email: 'Lisa@springfield.com', password: 'password')
      shrek_party = Party.create!(movie_id: 808, host_id: @user.id, date: '2023-01-01', time: '12:00', duration: 180)
      godfather_party = Party.create!(movie_id: 238, host_id: @lenny.id, date: '2023-05-01', time: '13:00',
                                      duration: 180)
      UserParty.create!(user_id: @user.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @lenny.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @bart.id, party_id: shrek_party.id)
      UserParty.create!(user_id: @lisa.id, party_id: shrek_party.id)

      UserParty.create!(user_id: @user.id, party_id: godfather_party.id)
      UserParty.create!(user_id: @bart.id, party_id: godfather_party.id)
      UserParty.create!(user_id: @lisa.id, party_id: godfather_party.id)
      visit dashboard_path
    end

    it 'displays multiple parties' do
      expect(page).to have_css('div#party', count: 2)
      expect(page).to have_content('Shrek')
      expect(page).to have_content('The Godfather')
    end

    it 'has all the people invited to the parties' do
      within('#movie_808 #invited') do
        expect(page).to have_content('Lenny')
        expect(page).to have_content('Bart')
        expect(page).to have_content('Lisa')
      end
      within('#movie_238 #invited') do
        expect(page).to have_content('Homer')
        expect(page).to have_content('Bart')
        expect(page).to have_content('Lisa')
      end
    end

    it 'says whether one is hosting or invited' do
      within('#movie_808') do
        expect(page).to have_content('I am Hosting')
        expect(page).to_not have_content('Host is')
      end
      within('#movie_238') do
        expect(page).to_not have_content('I am Hosting')
        expect(page).to have_content('Host is Lenny')
      end
    end
  end
end
