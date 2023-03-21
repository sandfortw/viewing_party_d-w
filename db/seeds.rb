# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_1 = User.create!(name: 'Dawson', email: 'DawsonTimmons@gmail.com')
user_2 = User.create!(name: 'Weston', email: 'Sandfortw@gmail.com')
user_3 = User.create!(name: 'Homer', email: 'Homer@springfield.com')
user_4 = User.create!(name: 'Marge', email: 'Marge@springfield.com')
user_5 = User.create!(name: 'Maggie', email: 'Maggie@springfield.com')
user_6 = User.create!(name: 'Bart', email: 'Bart@springfield.com')
user_7 = User.create!(name: 'Lisa', email: 'Lisa@springfield.com')
user_8 = User.create!(name: 'Krusty', email: 'Krusty@springfield.com')
user_9 = User.create!(name: 'Mr.Burns', email: 'CEO@springfield.com')
user_10 = User.create!(name: 'Lenny', email: 'Drunk@springfield.com')

party_1 = Party.create!(movie_id: 1, host_id: user_1.id, date: '2023-01-01', time: '12:00', duration: 300)
party_2 = Party.create!(movie_id: 2, host_id: user_2.id, date: '2023-02-01', time: '06:00', duration: 300)

user_party_1 = UserParty.create!(user_id: user_1.id, party_id: party_1.id)
user_party_2 = UserParty.create!(user_id: user_3.id, party_id: party_1.id)
user_party_3 = UserParty.create!(user_id: user_4.id, party_id: party_1.id)
user_party_4 = UserParty.create!(user_id: user_5.id, party_id: party_1.id)
user_party_5 = UserParty.create!(user_id: user_6.id, party_id: party_1.id)

user_party_6 = UserParty.create!(user_id: user_2.id, party_id: party_2.id)
user_party_7 = UserParty.create!(user_id: user_7.id, party_id: party_2.id)
user_party_8 = UserParty.create!(user_id: user_8.id, party_id: party_2.id)
user_party_9 = UserParty.create!(user_id: user_9.id, party_id: party_2.id)
user_party_10 = UserParty.create!(user_id: user_10.id, party_id: party_2.id)
