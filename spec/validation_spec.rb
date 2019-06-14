require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Validation do
  let(:dummy_class) { Class.new { extend Validation } }

  describe '.name_is_valid?' do
    it 'returns true cause of correct data' do
      expect(dummy_class.name_is_valid?('Rspec')).to eq(true)
    end

    it 'returns false cause of too short data' do
      expect(dummy_class.name_is_valid?('Rs')).to eq(false)
    end

    it 'returns false cause of too long data' do
      expect(dummy_class.name_is_valid?('RspecRspecRspecRspecR')).to eq(false)
    end

    it 'returns false cause of empty data' do
      expect(dummy_class.name_is_valid?('')).to eq(false)
    end

    it 'returns false cause of data is not a string' do
      expect(dummy_class.name_is_valid?(123)).to eq(false)
    end
  end

  describe '.guess_is_valid?' do
    it 'returns true cause of correct data' do
      expect(dummy_class.guess_is_valid?('1234')).to eq(true)
    end

    it 'returns false cause of incorrect data' do
      %w[123 12345 0123 3210 1237].each do |incorrect_data|
        expect(dummy_class.guess_is_valid?(incorrect_data)).to eq(false)
      end
    end
  end
end
