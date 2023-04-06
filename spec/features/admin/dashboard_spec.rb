require 'rails_helper'
describe 'admin dashboard page' do

  context 'when I log in as an admin user' do

    before do 
      @user = User.create!(name: 'Asdf', email: 'asdf@gmail.com', password: 'password', role: 2)
      @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password')
      @user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: 'password')
      @user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com', password: 'password')
      @user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com', password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit admin_dashboard_path
    end
    it 'should have a list of all default user\'s email addresses' do
      [@user_1, @user_2, @user_3].all? do |user|
        expect(page).to have_link(user.email)
      end
      
      expect(page).to_not have_content(@user.email)
      expect(page).to_not have_content(@user_4.email)

    end

    it 'when I click on an email, I am taken to the show page' do
      click_link @user_1.email
      expect(current_path).to eq(admin_user_path(@user_1.id))
    end

  end
end