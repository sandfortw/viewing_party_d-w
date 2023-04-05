require 'rails_helper'

# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page

describe 'login page' do

  before do 
    User.create!(name: 'Santa', email: 'santa@northpole.com', password: 'rudolph123')
  end
  it 'happy path' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq('/login')

    fill_in('email', with: 'santa@northpole.com')
    fill_in('password', with: 'rudolph123')
    click_on 'Log In'
    expect(current_path).to eq(user_path(User.last))
  end

  it 'sad path' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq('/login') 
    fill_in('email', with: 'santa@northpole.com')
    fill_in('password', with: 'santababy')
    click_on 'Log In'
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end