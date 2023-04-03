# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many :user_parties }
    it { should have_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:host_id) }
    it { should validate_presence_of(:movie_id) }
  end

  before do
    @user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com', password: 'password123', password_confirmation: 'password123')
    @user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com', password: 'password123', password_confirmation: 'password123')
    @user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_5 = User.create!(name: 'Maggie', email: 'Maggie@springfield.com',password: 'password123', password_confirmation: 'password123')
    @user_6 = User.create!(name: 'Bart', email: 'Bart@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_7 = User.create!(name: 'Lisa', email: 'Lisa@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_8 = User.create!(name: 'Krusty', email: 'Krusty@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_9 = User.create!(name: 'Mr.Burns', email: 'CEO@springfield.com', password: 'password123', password_confirmation: 'password123')
    @user_10 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com', password: 'password123', password_confirmation: 'password123')

    @party_1 = Party.create!(movie_id: 808, host_id: @user_1.id, date: '2023-01-01', time: '12:00', duration: 300)
    @party_2 = Party.create!(movie_id: 238, host_id: @user_2.id, date: '2023-02-01', time: '06:00', duration: 300)

    @user_party_1 = UserParty.create!(user_id: @user_1.id, party_id: @party_1.id)
    @user_party_2 = UserParty.create!(user_id: @user_3.id, party_id: @party_1.id)
    @user_party_3 = UserParty.create!(user_id: @user_4.id, party_id: @party_1.id)
    @user_party_4 = UserParty.create!(user_id: @user_5.id, party_id: @party_1.id)
    @user_party_5 = UserParty.create!(user_id: @user_6.id, party_id: @party_1.id)

    @user_party_6 = UserParty.create!(user_id: @user_2.id, party_id: @party_2.id)
    @user_party_7 = UserParty.create!(user_id: @user_7.id, party_id: @party_2.id)
    @user_party_8 = UserParty.create!(user_id: @user_8.id, party_id: @party_2.id)
    @user_party_9 = UserParty.create!(user_id: @user_9.id, party_id: @party_2.id)
    @user_party_10 = UserParty.create!(user_id: @user_10.id, party_id: @party_2.id)
  end

  describe '#movie', :vcr do
    it 'should return a movie' do
      expect(@party_1.movie.title).to eq 'Shrek'
      expect(@party_2.movie.title).to eq 'The Godfather'
    end
  end

  describe '#host_name' do
    it 'should return the host name' do
      expect(@party_1.host_name).to eq 'Dawson'
      expect(@party_2.host_name).to eq 'Weston'
    end
  end
end
