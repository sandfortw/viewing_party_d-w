# frozen_string_literal: true

require 'rails_helper'

describe 'home page' do
  before do
    @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password')
    @user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: 'password')
    @user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com', password: 'password')
    @user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com', password: 'password')
    visit root_path
  end

  it 'has the title of the application' do
    expect(page).to have_content('Viewing Party')
  end

  it 'has a button to create a new user' do
    expect(page).to have_button('Create New User')
    click_button('Create New User')
    expect(current_path).to eq(register_path)
  end

  it 'has a list of the users emails if logged in, and a link to log out' do
    visit root_path
    click_on 'Log In'
    fill_in 'email', with: @user_1.email
    fill_in 'password', with: @user_1.password
    click_on 'Log In'
    visit root_path

    expect(page).to have_content(@user_1.email)
    expect(page).to have_content(@user_2.email)
    expect(page).to have_content(@user_3.email)
    expect(page).to have_content(@user_4.email)
    expect(page).to have_link('Log Out')

  end

  it 'does not have a list of emails if not logged in' do
    expect(page).to_not have_content(@user_1.email)
    expect(page).to_not have_content(@user_2.email)
    expect(page).to_not have_content(@user_3.email)
    expect(page).to_not have_content(@user_4.email)
    expect(page).to_not have_link('Log Out')


    expect(page).to have_link("Log In")
    expect(page).to have_link('Checkout some movies, visitor!')
  end

  
  it 'when I log out, as a logged in user, I no longer see the log out link and see a log in link instead' do
    visit root_path
    click_on 'Log In'
    fill_in 'email', with: @user_1.email
    fill_in 'password', with: @user_1.password
    click_on 'Log In'
    visit root_path

    click_on "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Log Out")
    expect(page).to have_link("Log In")
  end

  it 'as a visitor, I cannot view a dashboard' do
    click_on 'My dashboard'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in or registered to access your dashboard.")
  end

  it 'has a link back to the landing page (the current page)' do # TODO: make a layout test
    expect(page).to have_link('Home')
    click_link('Home')
    expect(current_path).to eq(root_path)
  end
end
