require 'rails_helper'

describe 'movies page' do
  context 'top 20 button clicked' do
    before do 
      @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
      visit user_discover_path(@user)
      click_button "Find Top Rated Movies"
    end
    it 'should have the title of the top 20 movies (3)', :vcr do
      expect(current_path).to eq(user_movies_path(@user))
      expect(page).to have_content("The Godfather")
    end
  end
end