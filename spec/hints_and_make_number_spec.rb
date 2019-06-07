require_relative '../game/game_logic'

RSpec.describe 'Hints' do
  include GameLogic

  secret_code = '1234'
  unused_hints = secret_code.chars

  it 'should be included in secret code' do
    secret_code.should include(hint(unused_hints))
  end

  it 'should be shorter then before' do
    old_length = unused_hints.length
    hint(unused_hints)
    unused_hints.length.should be < old_length
  end

  it 'should be unique' do
    unused_hints.should !include(hint(unused_hints))
  end
end

RSpec.describe 'Make number' do
  include GameLogic

  it 'should be a number between 1111 and 6666' do
    secret_code = make_number
    secret_code.should be >= 1111
    secret_code.should be <= 6666
  end
end
