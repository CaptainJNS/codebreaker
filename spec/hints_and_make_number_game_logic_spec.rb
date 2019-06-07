require_relative '../game/game_logic'

RSpec.describe GameLogic do
  include described_class

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
    it 'is a number between 1111 and 6666' do
      secret_code = make_number
      secret_code.should be >= 1111
      secret_code.should be <= 6666
    end
  end
end
