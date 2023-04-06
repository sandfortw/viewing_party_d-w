require 'rails_helper'

RSpec.describe "Logging In" do
  before do
    @user = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password123', password_confirmation: 'password123')
    visit root_path
  end
  context 'happy path' do
    it "can log in with valid credentials" do
      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      fill_in :password_confirmation, with: @user.password_confirmation

      click_on "Log In"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Welcome, #{@user.name}")
    end
  end

  context 'sad path' do 
    it "does not allow the user to log in with an invalid password" do
      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: @user.email
      fill_in :password, with: 1234
      fill_in :password_confirmation, with: @user.password_confirmation

      click_on "Log In"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Sorry, your credentials are bad.")
    end

    it "does not allow the user to log in with an invalid email" do
      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: "Dawson@gmail.com"
      fill_in :password, with: @user.password
      fill_in :password_confirmation, with: @user.password_confirmation

      click_on "Log In"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end