require 'rails_helper'

describe 'admin user show page' do
  before do
    @user = User.create!(name: 'Asdf', email: 'asdf@gmail.com', password: 'password', role: 2)
    @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_user_path(@user_1.id)
  end

  it 'should have the same stuff as the user show page' do
    expect(page).to have_content("#{@user.name}'s Dashboard")
    expect(page).to have_content('My Viewing Parties')
    expect(page).to have_button 'Discover Movies'
  end
end