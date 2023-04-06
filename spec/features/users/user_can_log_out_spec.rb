require 'rails_helper'

RSpec.describe "Logging Out" do
  before do
    @user = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password123', password_confirmation: 'password123')
    visit root_path
  end
  context 'happy path' do
    it "can log out" do
      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      fill_in :password_confirmation, with: @user.password_confirmation

      click_on "Log In"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.name}")

      visit root_path
      expect(page).to have_button("Log Out")

      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You have successfully logged out!")
      expect(page).to have_button("Create New User")
      expect(page).to have_button("Log In")
      expect(page).to_not have_button("Log Out")
    end
  end
end