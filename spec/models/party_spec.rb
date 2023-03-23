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
end
