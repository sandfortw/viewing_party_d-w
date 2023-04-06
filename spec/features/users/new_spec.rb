# frozen_string_literal: true

require 'rails_helper'

describe 'the user new page' do
  before do
    visit '/register'
  end

  context 'shows the user a form to register, and this form includes' do
    it 'has a name field' do
      expect(page).to have_field(:name)
    end

    it 'has an email field' do
      expect(page).to have_field(:email)
    end

    it 'has a button to register' do
      expect(page).to have_button('Register')
    end
  end
  describe 'happy path' do
    it 'registers the user with valid information' do
      
      fill_in :name, with: 'Dawson'
      fill_in :email, with: 'DawsonTimmons@gmail.com'
      fill_in :password, with: 'password123'
      fill_in :password_confirmation, with: 'password123'
      click_button 'Register'

      expect(current_path).to eq(dashboard_path)
    end
  end

  describe 'sad path' do
    before do
      User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: 'password123', password_confirmation: 'password123')
    end
    it 'does not accept an email that already exists' do
      fill_in :name, with: 'Charles'
      fill_in :email, with: 'Sandfortw@gmail.com'
      fill_in :password, with: 'password123'
      fill_in :password_confirmation, with: 'password123'
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'does not submit with empty fields' do
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email can't be blank, Name can't be blank")
    end

    it 'does not submit if the passwords do not match' do
      fill_in :name, with: 'Dawson'
      fill_in :email, with: 'DawsonTimmons@gmail.com'
      fill_in :password, with: 'password123'
      fill_in :password_confirmation, with: 'password'
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'does not submit with an empty field name' do
      fill_in :name, with: ''
      fill_in :email, with: 'DawsonTimmons@gmail.com'
      fill_in :password, with: 'password123'
      fill_in :password_confirmation, with: 'password123'
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end
  end
end
