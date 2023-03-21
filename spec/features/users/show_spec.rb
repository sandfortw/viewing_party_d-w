require 'rails_helper'

describe 'user dashboard (show page)' do
  before do
    @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
    visit user_path(@user)
  end
  
  it 'has a header' do
    expect(page).to have_content("#{@user.name}'s Dashboard")
  end

  it 'has a section that lists viewing parties' do
    expect(page).to have_content("My Viewing Parties")
  end

  describe 'discover page button' do
    it 'has a button to discover movies' do
      expect(page).to have_button "Discover Movies"
    end

    it 'links to a user\'s discover page' do
      click_button 'Discover Movies' 
      expect(current_path).to eq(user_discover_path(@user))
    end
  end
end