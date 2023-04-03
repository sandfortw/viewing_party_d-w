require 'rails_helper'

# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page

describe 'login page' do

  it 'should do all the things I need' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq('/login')

    fill_in('email', with: 'santa@northpole.com')
    fill_in('password', with: 'rudolph123')
    expect(current_path).to eq(user_show_path(User.last))
  end
end