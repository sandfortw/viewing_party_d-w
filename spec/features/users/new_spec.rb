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

    it 'should have a password field' do
      expect(page).to have_field(:name)
    end

    it 'should have a password_confirmation field' do
      expect(page).to have_field(:password_confirmation)
    end

    it 'has a button to register' do
      expect(page).to have_button('Register')
    end
  end
  describe 'happy path' do
    it 'registers the user with valid information' do
      fill_in :name, with: 'Dawson'
      fill_in :email, with: 'DawsonTimmons@gmail.com'
      fill_in :password, with: '1234'
      fill_in :password_confirmation, with: '1234'

      click_button 'Register'

      expect(current_path).to eq(dashboard_path)
      expect(User.last.authenticate('1234')).to eq(User.last)
      expect(User.last.authenticate('134')).to_not eq(User.last)
    end
  end

  describe 'sad path' do
    before do
      User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: '1234')
    end
    it 'does not accept an email that already exists' do
      fill_in :name, with: 'Charles'
      fill_in :email, with: 'Sandfortw@gmail.com'
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'does not submit with empty fields' do
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email can't be blank, Name can't be blank")
    end

    it 'will not submit without a password' do
      fill_in :name, with: 'Aasdf'
      fill_in :email, with: 'asdfafsd@gmail.com'
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Password can\'t be blank')
    end

    it 'flashes a message when the passwords do not match' do
      fill_in :name, with: 'Dawson'
      fill_in :email, with: 'DawsonTimmons@gmail.com'
      fill_in :password, with: '1234'
      fill_in :password_confirmation, with: '124'

      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Passwords do not match')
    end
  
  end

  describe 'authentication' do
    it 'should have a password field' do
      expect(page).to have_field(:name)
    end
  end
end
