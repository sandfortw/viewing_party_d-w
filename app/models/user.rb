# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
