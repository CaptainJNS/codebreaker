require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe GameLogic do
  let(:dummy_class) { Class.new { extend GameLogic } }

  describe '.check_numbers' do
    let(:samples) { YAML.load_file('./spec/samples.yml') }

    it 'returns a correct answer' do
      samples.each do |sample|
        expect(dummy_class.check_numbers(sample[0].chars, sample[1].chars)).to eq(sample[2])
      end
    end
  end

  describe '.hint' do
    let(:secret_code) { '1234' }
    let(:unused_hints) { secret_code.chars }

    it 'is included in secret code' do
      expect(secret_code).to include(dummy_class.hint(unused_hints))
    end

    it 'is shorter then before' do
      old_length = unused_hints.length
      dummy_class.hint(unused_hints)
      expect(unused_hints.length).to be < old_length
    end

    it 'is unique' do
      expect(unused_hints).not_to include(dummy_class.hint(unused_hints))
    end
  end

  describe '.make_number' do
    it 'is a number of 4 digits, each digit is in the range 1-6' do
      secret_code = dummy_class.make_number
      expect(secret_code).to match(/^[1-6]{4}$/)
    end
  end

  describe '.calc_attempts_and_hints' do
    it 'returns a number of attempts depends on difficulty' do
      test_data = [
        ['Easy', 15],
        ['Medium', 10],
        ['Hard', 5],
        ['HELL', 3]
      ]

      test_data.each { |test_case| expect(dummy_class.calc_attempts_and_hints(test_case[0])[0]).to eq(test_case[1]) }
    end

    it 'returns a number of hints depends on difficulty' do
      test_data = [
        ['Easy', 3],
        ['Medium', 2],
        ['Hard', 1],
        ['HELL', 0]
      ]

      test_data.each { |test_case| expect(dummy_class.calc_attempts_and_hints(test_case[0])[1]).to eq(test_case[1]) }
    end
  end
end
