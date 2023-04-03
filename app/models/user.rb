# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  validates :password_digest, presence: true

  has_secure_password
end
