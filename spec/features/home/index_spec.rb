# frozen_string_literal: true

require 'rails_helper'

describe 'home page' do
  before do
    @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password123', password_confirmation: 'password123')
    @user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: 'password123', password_confirmation: 'password123')
    @user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com', password: 'password123', password_confirmation: 'password123')
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

  it 'has a link back to the landing page (the current page)' do
    expect(page).to have_link('Home')
    click_link('Home')
    expect(current_path).to eq(root_path)
  end

  context 'Auth challenge' do
    context 'as a visitor' do
      it 'does not show the list of existing users' do
        expect(page).to_not have_content(@user_1.email)
        expect(page).to_not have_content(@user_2.email)
        expect(page).to_not have_content(@user_3.email)
        expect(page).to_not have_content(@user_4.email)
      end
    end
    
    context 'as a registered user' do
      before do
        click_on "Log In"

        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password
        fill_in :password_confirmation, with: @user_1.password_confirmation

        click_on "Log In"

        visit root_path
      end
      it 'shows a list of all the existing users emails' do
        expect(page).to have_content(@user_1.email)
        expect(page).to have_content(@user_2.email)
        expect(page).to have_content(@user_3.email)
        expect(page).to have_content(@user_4.email)
      end
    end
  end
end
