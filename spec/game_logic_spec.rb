require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe GameLogic do
  include described_class

  describe '.check_numbers' do
    let(:samples) { YAML.load_file('./spec/samples.yml') }

    it 'returns a correct answer' do
      samples.each do |sample|
        expect(check_numbers(sample[0], sample[1])).to eq(sample[2])
      end
    end
  end

  describe '.hint' do
    secret_code = '1234'
    unused_hints = secret_code.chars

    it 'is included in secret code' do
      secret_code.should include(hint(unused_hints))
    end

    it 'is shorter then before' do
      old_length = unused_hints.length
      hint(unused_hints)
      unused_hints.length.should be < old_length
    end

    it 'is unique' do
      unused_hints.should_not include(hint(unused_hints))
    end
  end

  describe '.make_number' do
    it 'is a number of 4 digits, each digit is in the range 1-6' do
      secret_code = make_number
      /^[1-6]{4}$/.match?(secret_code).should be true
    end
  end

  describe '.calc_attempts' do
    it 'returns a number of attempts depends on difficulty' do
      test_data = [
        ['Easy', 15],
        ['Medium', 10],
        ['Hard', 5],
        ['HELL', 3]
      ]

      test_data.each { |test_case| expect(calc_attempts(test_case[0])).to eq(test_case[1]) }
    end
  end

  describe '.calc_hints' do
    it 'returns a number of hints depends on difficulty' do
      test_data = [
        ['Easy', 3],
        ['Medium', 2],
        ['Hard', 1],
        ['HELL', 0]
      ]

      test_data.each { |test_case| expect(calc_hints(test_case[0])).to eq(test_case[1]) }
    end
  end
end
