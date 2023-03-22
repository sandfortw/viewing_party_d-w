require 'rails_helper'

describe 'movies page' do
  context 'top 20 button clicked', :vcr do
    before do 
      @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
      visit user_discover_path(@user)
      click_button "Find Top Rated Movies"
    end
    it 'should have the title of the top 20 movies (3)' do
      expect(current_path).to eq(user_movies_path(@user))
      expect(page).to have_link("The Godfather")
      expect(page).to have_link("The Shawshank Redemption")
      expect(page).to have_link("Cuando Sea Joven")
    end

    it 'a title links to its show page' do
      click_link("The Godfather")
      expect(current_path).to eq(user_movie_path(@user, 238))
    end

    it 'a title links to its show page' do
      click_link("The Godfather")
      expect(current_path).to eq(user_movie_path(@user, 238))
    end

  end
end