require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe GameLogic do
  include described_class

  describe '#check_numbers' do
    it { expect(check_numbers('6543', '5643')).to eq('++--') }

    it { expect(check_numbers('6543', '6411')).to eq('+-') }

    it { expect(check_numbers('6543', '6544')).to eq('+++') }

    it { expect(check_numbers('6543', '3456')).to eq('----') }

    it { expect(check_numbers('6543', '6666')).to eq('+') }

    it { expect(check_numbers('6543', '2666')).to eq('-') }

    it { expect(check_numbers('6543', '2222')).to eq('') }

    it { expect(check_numbers('6666', '1661')).to eq('++') }

    it { expect(check_numbers('1234', '3124')).to eq('+---') }

    it { expect(check_numbers('1234', '1524')).to eq('++-') }

    it { expect(check_numbers('1234', '1234')).to eq('++++') }
  end

  describe '#hint' do
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

  describe '#make_number' do
    it 'is a number of 4 digits, each digit is in the range 1-6' do
      secret_code = make_number
      /^[1-6]{4}$/.match?(secret_code).should be true
    end
  end
end
