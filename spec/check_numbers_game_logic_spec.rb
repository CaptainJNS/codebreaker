require_relative 'spec_helper'
require_relative '../game/game_logic'

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
end
