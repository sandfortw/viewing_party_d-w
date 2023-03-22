require 'rails_helper'

describe 'movies page' do
  context 'top 20 button clicked' do
    before do 
      VCR.use_cassette("top_20") do
        @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
        visit user_discover_path(@user)
        click_button "Find Top Rated Movies"
      end
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

    it 'has 20 results' do
      expect(page).to have_css('#movie', count: 20)
    end

    it 'has the average vote count' do
      expect(page).to have_content('The Godfather Vote Average: 8.7')
      expect(page).to have_content('Schindler\'s List Vote Average: 8.6')
      expect(page).to have_content('12 Angry Men Vote Average: 8.5')
    end

    it 'should have a button that links to the Discover Movies page' do
      expect(page).to have_button("Discover Movies")
      click_button("Discover Movies")
      expect(current_path).to eq(user_discover_path(@user))
    end
  end

  context 'search for a movie(Forrest Gump)' do 
    before do 
      VCR.use_cassette("Forrest Gump") do
        @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
        visit user_discover_path(@user)
        fill_in :search, with: "Forrest Gump"
        click_button "Find Movies"
      end
    end

      it 'should have the title of the movie(Forrest Gump)' do
        expect(page).to have_link('Forrest Gump')
      end
    
      it 'each results should be a link' do
        click_link("Forrest Gump")
        expect(current_path).to eq(user_movie_path(@user, 13))
      end

      it 'should have multiple results' do
        expect(page).to have_content("Forrest Gump Vote Average: 8.481")
        expect(page).to have_content('Through the Eyes of Forrest Gump Vote Average: 7.8')
      end

      it 'should have a button that links to the Discover Movies page' do
        expect(page).to have_button("Discover Movies")
        click_button("Discover Movies")
        expect(current_path).to eq(user_discover_path(@user))
      end
  end

  context 'search for a movie(F)' do 
    before do 
      VCR.use_cassette("F Search") do
        @user = User.create!(name: 'Homer', email: 'Homer@springfield.com')
        visit user_discover_path(@user)
        fill_in :search, with: "F"
        click_button "Find Movies"
      end
    end

    it 'page is limited to 20 results' do
      expect(page).to have_css('#movie', count: 20)
    end
  end
end