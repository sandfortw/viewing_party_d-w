# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :time, presence: true
  validates :date, presence: true
  validates :host_id, presence: true
  validates :movie_id, presence: true
  validates :duration, presence: true
end
