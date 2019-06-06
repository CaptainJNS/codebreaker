require_relative '../dependency'

RSpec.describe 'Numbers check' do
  include GameLogic

  it 'should be equal' do
    expect(check_numbers('6543', '5643')).to eq('++--')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '6411')).to eq('+-')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '6544')).to eq('+++')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '3456')).to eq('----')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '6666')).to eq('+')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '2666')).to eq('-')
  end

  it 'should be equal' do
    expect(check_numbers('6543', '2222')).to eq('')
  end

  it 'should be equal' do
    expect(check_numbers('6666', '1661')).to eq('++')
  end

  it 'should be equal' do
    expect(check_numbers('1234', '3124')).to eq('+---')
  end

  it 'should be equal' do
    expect(check_numbers('1234', '1524')).to eq('++-')
  end

  it 'should be equal' do
    expect(check_numbers('1234', '1234')).to eq('++++')
  end
end
