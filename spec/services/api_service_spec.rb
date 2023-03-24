# frozen_string_literal: true

require 'rails_helper'

describe ApiService do
  describe 'class methods' do
    describe '.movie_call(url)' do
      it 'returns a hash object', :vcr do
        call = ApiService.movie_call('3/movie/808')
        expect(call).to be_a(Hash)
        expect(call[:id]).to eq(808)
        expect(call[:original_title]).to eq('Shrek')
      end
    end
  end
end
