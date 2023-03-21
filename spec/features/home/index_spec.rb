# frozen_string_literal: true

require 'rails_helper'

describe 'home page' do
  before do
    @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com')
    @user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com')
    @user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com')
    @user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com')
    visit root_path
  end

  it 'has the title of the application' do
    expect(page).to have_content('Viewing Party')
  end

  it 'has a button to create a new user' do
    expect(page).to have_button('Create New User')
    click_button('Create New User')
    expect(current_path).to eq(new_user_path)
  end

  it 'lists the existing users which links to the user\'s dashboard' do
    expect(page).to have_link('Dawson')
    expect(page).to have_link('Weston')
    expect(page).to have_link('Homer')
    expect(page).to have_link('Marge')
    click_link('Dawson')
    expect(current_path).to eq(user_path(@user_1.id))
  end

  it 'has a link back to the landing page (the current page)' do # TODO: make a layout test
    expect(page).to have_link('Home')
    click_link('Home')
    expect(current_path).to eq(root_path)
  end
end
