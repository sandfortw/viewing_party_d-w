require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe 'runtime_format(runtime)' do
    it 'formats times' do
      expect(runtime_format(60)).to eq('1hr 0min')
      expect(runtime_format(90)).to eq('1hr 30min')
      expect(runtime_format(186)).to eq('3hr 6min')
    end
  end
end