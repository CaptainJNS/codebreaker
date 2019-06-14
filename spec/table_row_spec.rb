require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe TableRow do
  test = 'test'

  it 'shows correctly' do
    row = described_class.new(
      name: test,
      difficulty: test,
      att_total: test,
      att_used: test,
      hints_total: test,
      hints_used: test
    )
    expect(row.to_s).to eq(I18n.t(:stats,
                                  name: test,
                                  difficulty: '',
                                  att_total: test,
                                  att_used: test,
                                  hints_total: test,
                                  hints_used: test))
  end
end
